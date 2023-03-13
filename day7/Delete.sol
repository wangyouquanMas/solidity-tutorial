// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract DeleteExample{
    uint[] public numbers;
    mapping(string => uint) public keyValue;

    function deleteNumber() public{
        delete numbers;
    }

    function deleteKeyValue(string memory key) public{
        delete keyValue[key];
    }

    event deleteLog(string string1);
    string  public _string = "true";
    function d() external returns(string memory){
        delete _string;

        emit deleteLog(_string);
        return _string;
    }
}