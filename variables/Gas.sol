// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Gas{
    uint public i = 0;

    function forever() public{
        while(true){
            i+=1;
        }
    }
}