pragma solidity ^0.8.0;
//目的：检测bytes用法

contract BytesExample{
    function createBytes() public pure returns (bytes memory){
        bytes memory myBytes = new bytes(5);
        return myBytes;
    }
}