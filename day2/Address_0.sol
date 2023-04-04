
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Address_0{
    event Log(address addr);
    address addr = address(0);
    function test() public {
        emit  Log(addr);
    }
}