
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Map{
    mapping(address => uint) public  balances;

    function deposit() public payable{
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint amount) public{
        require(balances[msg.sender] >= amount);
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }
}