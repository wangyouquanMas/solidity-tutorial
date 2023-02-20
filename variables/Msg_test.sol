// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Msg_test{
    function EtherTest() public returns (bool){
      return Assert.equal(msg.sender ,1e18,"1 ether is not equal to 1e18");
    }
}

contract Caller{
    function 
}