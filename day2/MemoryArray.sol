// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

contract MemoryArray {
    function f(uint len) public pure{
        uint[] memory a  = new uint[](7);
        bytes memory b = new bytes(len);
        assert(a.length == 7);
        assert(b.length == len);
        a[6] = 8;
    }
}