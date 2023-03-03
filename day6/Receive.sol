pragma solidity ^0.8.0;

contract Payable {
    event receiveLog(uint amount);
    event fallbackLog(uint amount);
    fallback() external payable {
        // 处理接收到的以太币
        emit fallbackLog(2);
    }

    receive() external payable {
        // 处理接收到的以太币
        emit receiveLog(1);
    }
}

contract Caller{
    function deposit(address payable _addr) public payable{
       (bool success, bytes memory data) =  _addr.call{value:msg.value}("");
    }
}