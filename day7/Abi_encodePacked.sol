pragma solidity ^0.8.0;

//功能: pack multiple values into a single byte array
//it takes any number of arguments and returns a byte array that contains the packed values 


//应用场景： is often used when working with low-level operations, such as creating or verifying cryptographic signatures or constructing data structures that need to be serialized and transmitted efficiently.
contract Abi_encodePacked{
    function encodePackedExample(uint256 _num,address _addr) public returns (bytes memory){
        bytes memory packed = abi.encodePacked(_num,_addr);
        return packed;
    }
}