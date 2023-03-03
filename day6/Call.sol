pragma solidity ^0.8.0;

contract Caller{
    function call(address target ,uint _num) public returns (bool,bytes memory){
       (bool success,bytes memory result) =  target.call(abi.encodeWithSignature("setN(uint256)",_num));
        return (success,result);
    }
}

contract Callee{
    uint public n;
    event targetLog(uint n,address user);

    function setN(uint _n) public{
        n = _n;
        emit targetLog(_n,msg.sender);
    }
}