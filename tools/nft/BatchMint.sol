// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

//相当于是interface
// 需要和target交互，因此就需要先确定我需要用到target中哪些东西【方法】。
//  抽象出来设计接口

// 接口和目标contract需要链接
contract Deployed {
    function mint(uint256 amount) public payable {}

//用于判断每个子合约持有哪些token ID ，才能确定那个NFT需要被转换回来
    function tokenOfOwnerByIndex(address user, uint256 id)
        public
        view
        returns (uint256)
    {}
}

contract contractMint is IERC721Receiver, Ownable {
    Deployed dc;
    //? 调用者地址？ 
    address target;
    uint256 public MAX_SUPPLY;
    uint256 public NFT_PRICE;
    uint256 public MAX_PER_WALLET;
    event log(address user, uint256 id);

    constructor(
        address _target,
        uint256 _max_supply,
        uint256 _nft_price,
        uint256 _max_per_wallet
    ) payable {
        target = _target;

        //
        dc = Deployed(_target);
        MAX_SUPPLY = _max_supply;
        NFT_PRICE = _nft_price;
        MAX_PER_WALLET = _max_per_wallet;
    }

    function onERC721Received(
        address _operator,
        address _from,
        uint256 _tokenId,
        bytes memory _data
    ) public override returns (bytes4) {
        return 0x150b7a02;
    }

//target ? 
    function mint(uint256 _val) external payable onlyOwner {
        (bool success, ) = target.call{value: _val * NFT_PRICE}(
            //每次message要根据要交互的合约进行更改
            abi.encodePacked(bytes4(keccak256("mint(uint256)")), _val)
        ); // D's storage is set, E is not modified
        require(success);
    }

//打给操作者
    function withdrawMoney() external onlyOwner {
        (bool success, ) = msg.sender.call{value: address(this).balance}("");
        require(success, "Transfer failed.");
    }

//指定合约剩余钱接收对象
    function withdraw(address recipient) public onlyOwner {
        (bool success, ) = payable(recipient).call{
            value: address(this).balance
        }("");
        require(success, "WITHDRAWAL_FAILED");
    }

    function withdrawNFT(address recipient) external onlyOwner {
        ERC721 token = ERC721(target);
        for (uint256 i = 0; i < MAX_PER_WALLET; i++) {
            if (token.balanceOf(address(this)) > 0) {
                //TODO : use call instead of interface
                // (bool success, bytes memory returnData) = target.call(bytes4(keccak256(abi.encodePacked("tokenOfOwnerByIndex(address,uint256)")),address(this), i));
                // require(success);
                uint256 tokenId = dc.tokenOfOwnerByIndex(address(this), 0);
                require(
                    token.ownerOf(tokenId) == address(this),
                    "You must own the token"
                );
                token.transferFrom(address(this), recipient, tokenId);
            }
        }
    }
}

contract mintFactory is Ownable {
    //存储所有的子合约 【storage】
    contractMint[] public _mint;
    //根据具体要交互的合约，来根据规则进行修改
    uint256 public constant MAX_SUPPLY = 10000;
    uint256 public constant NFT_PRICE = 0.0000001 ether;
    uint256 public constant MAX_PER_WALLET = 2;

    //price价格估算?
    //这里payable去掉也可以 【只是参考代码，不要“太敬畏”】
    //理解payable用法？
    // {
    // value: (MAX_PER_WALLET + 1) * NFT_PRICE
    // }: 表示每次构造时往这个子合约里打了value钱
    function createMint(address _t) external payable {
        contractMint mintContract = new contractMint{
            value: (MAX_PER_WALLET + 1) * NFT_PRICE
        }(_t, MAX_SUPPLY, NFT_PRICE, MAX_PER_WALLET);
        _mint.push(mintContract);
    }

    //
    function createBatchMint(address _t, uint256 _num)
        external
        payable
        onlyOwner
    {
        require(
            msg.value >= (MAX_PER_WALLET + 1) * NFT_PRICE * _num,
            "Not enough eth to pay"
        );
        for (uint256 i = 0; i < _num; i++) {
            this.createMint(_t);
        }
    }

//开始mint中没有transfer,不需要交钱动作，可以将操作gas拉高，可以抢险交易
//
    function batchMintStart() external onlyOwner {
        for (uint256 i = 0; i < _mint.length; i++) {
            //call 子合约里的mint函数
            _mint[i].mint(MAX_PER_WALLET);
        }
    }

    function batchWithdraw(address recipient) external onlyOwner {
        for (uint256 i = 0; i < _mint.length; i++) {
            _mint[i].withdraw(recipient);
            _mint[i].withdrawNFT(recipient);
        }
    }
}