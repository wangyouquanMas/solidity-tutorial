
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Array{
    uint[] public dynamicArray;
    uint[5] public fixedArray;

    function addToDynamicArray(uint value) public{
        dynamicArray.push(value);
    }

    function setFixedArrayValue(uint index,uint value) public{
        fixedArray[index] = value;
    }
}