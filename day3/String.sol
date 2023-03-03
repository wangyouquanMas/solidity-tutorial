
pragma solidity ^0.8.17;

contract String{
    string public data;

    function setData(string memory newData) public{
        data = newData;
    }

    function getData() public view returns (string memory){
        return data;
    }
}