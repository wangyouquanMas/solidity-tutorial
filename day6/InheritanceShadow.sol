// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract A {
    uint public x = 1;
}

contract B is A {
    constructor(){
        x =2; 
    }

    function getAx() public returns (uint){
        return super.x;
    }
}

