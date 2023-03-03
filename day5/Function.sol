pragma solidity ^0.8.17;

contract Function{
    function add(uint a, uint b) public returns (uint){
        return a+b;
    }

     function add(uint a, uint b,uint c) public returns (uint){
        return a+b+c;
    }
}