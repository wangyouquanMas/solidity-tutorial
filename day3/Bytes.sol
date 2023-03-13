
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Bytes{
    bytes public data;

    function setData(bytes memory newData) public{
        data = newData;
    }

    function getData() public view returns (bytes memory){
        return data;
    }

    function pushByte(bytes1  b) public{
        data.push(b);
    }
}