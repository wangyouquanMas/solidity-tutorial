
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;


contract Primitives{
    bool boo = true; 

    //uint是uint256别名
    uint8 u8 = 255;
    uint u256 = 456;
    uint u = 123; 

    //
    int8 i8 =-1;
    int i256 = 456;
    int i = -123;
    int minInt = type(int).min;
    int maxInt = type(int).max;
}