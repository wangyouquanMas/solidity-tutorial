pragma solidity ^0.8.17;

contract Selector{
   function doSomething(uint a, uint b) public pure returns (uint){
       return a+b;
   } 

     function mintSelector() external pure returns(bytes4 mSelector){
        return bytes4(keccak256("doSomething(uint,uint)"));
    }
}


contract caller{
    event SelectorLog(bool success, bytes data);
    function selectorCall(address _addr) public{
       (bool success, bytes memory data) =  _addr.call(abi.encodeWithSignature("doSomething(uint,uint)",1,2));
       emit SelectorLog(success, data);
    }
}