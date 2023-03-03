pragma solidity ^0.8.0;

contract WeiEther{
    event WeiEtherLog(address sender,uint value, uint balance);
    function pay() public payable{
        require(msg.value >= 1 wei);
        
        address payable receiver = payable(0x1234567890123456789012345678901234567890);

        receiver.transfer(msg.value);

        emit WeiEtherLog(msg.sender, msg.value,receiver.balance);
    }
}