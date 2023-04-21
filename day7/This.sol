pragma solidity ^0.8.0;
//检测 this用法

contract ThisExample{
    uint256 public myNumber;

    function setNumber(uint256 _number) public{
        myNumber = _number;
    }

    function getNumber() public view returns (uint256){
        return myNumber;
    }

    function getContractAddress() public view returns (address){
        return address(this);
    }
}