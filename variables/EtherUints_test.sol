// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract EtherUnits{
    uint public oneWei = 1 wei;

    bool public isOneWei = 1 wei == 1;

    uint public oneEther = 1 ether;

    bool public isOneEther = 1 ether == 1e18;

    function EtherTest() public returns (bool){
      return Assert.equal(oneEther ,1e18,"1 ether is not equal to 1e18");
    }
}