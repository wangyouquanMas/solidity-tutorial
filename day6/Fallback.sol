pragma solidity ^0.8.0;

contract Payable {
    fallback() external payable {
        // 处理接收到的以太币
    }
}

contract Caller{
    function deposit(address payable _addr) public payable{
       (bool success, bytes memory data) =  _addr.call{value:msg.value}("");
    }
}