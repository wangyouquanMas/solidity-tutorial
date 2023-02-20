// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract EtherStore{
    mapping(address => uint ) public balances;

    // bool internal locked;

    // modifier noReentrancy(){
    //     require(!locked,"No re-entrancy");
    //     locked = true;
    //     _;
    //     locked = false;
    // }

//1 payable 表示函数可以接收还是发送 ether? 
    function deposit() public payable{
        balances[msg.sender] += msg.value;
    }


uint256 private _status; // 重入锁

// 重入锁
modifier nonReentrant() {
    // 在第一次调用 nonReentrant 时，_status 将是 0
    require(_status == 0, "ReentrancyGuard: reentrant call");
    // 在此之后对 nonReentrant 的任何调用都将失败
    _status = 1;
    _;
    // 调用结束，将 _status 恢复为0
    _status = 0;
}

    function withdraw() public  nonReentrant {
        uint bal = balances[msg.sender];
        require(bal >0);

     
//2call 用法
        (bool sent,) = msg.sender.call{value: bal}("");   
        //3requie支持 option message?
        require(sent,"Failed to send Ether");
    
        //msg.sender的状态还没有更新，新的withdraw请求就进来了【并发安全....只不过这里的危害体现在了钱上】
       balances[msg.sender] = 0;
    }

//4 view用法？
    function getBalance() public view returns(uint){
        
//5 address用法？ this作用? 更新到7天系列
        return address(this).balance;
    }
}

contract Attack{
    //6在另一个合约中初始化合约
    EtherStore public etherStore;
     mapping(address => uint ) public balances;
    constructor(address _etherStoreAddress){
        //6.1 对合约实例化  ？啥意思代码
        etherStore = EtherStore(_etherStoreAddress);
    }

    //7fallback使用方法及规定？
    fallback() external payable{
        //6.2 合约调用自己的属性和方法 方式？
        if (address(etherStore).balance >= 1 ether){
            // etherStore.withdraw();
        }
    }

    function attack() external payable{
        require(msg.value>= 1 ether);
        etherStore.deposit{value: 1 ether}();
        etherStore.withdraw();
    }


    function getBalance() public view returns (uint){
        return address(this).balance;
    }
}

// contract C{

//     Attack  public attack;
//        constructor(address  _attack){
//         //6.1 对合约实例化  ？啥意思代码
//         attack = Attack(_attack);
//     }

//        function deposit() external payable{
//         require(msg.value>= 1 ether);
//         attack.deposit{value: 1 ether}();
//     }

// }