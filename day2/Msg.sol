pragma solidity ^0.8.0;

contract Msg{
    event MsgLog(uint value, address sender,uint gaslimit);
    function exampleFunction() public payable{
        address payable recipient = payable(0x1234567890123456789012345678901234567890);
        recipient.transfer(msg.value);

        emit MsgLog(msg.value,msg.sender,block.gaslimit);
    }
}