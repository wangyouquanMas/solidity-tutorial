
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./Interface_storage.sol";
// import "./Library_storage.sol";
import "./Library_person.sol";
import "./Implementation_storageInterface.sol";

contract Storage_function{
    event log(uint res);
    Library_person.Person public person;
    function setStorage(address _storage)external {
        //?接口用法
        person.interface_storage = Interface_storage(_storage);
    }

    function test() public {
        //问题1： 在 Solidity 中，对于变量，必须指定其数据位置。如果不指定，则编译器会发出 TypeError 错误。??? 下面的res没定义
        //语法1： 接口中结构体调用方式，以及其它类型调用方式？
        // Interface_storage.Person memory person = Interface_storage.Person({name:"wang",age:18,gender:"man"});
        uint res = person.test_storage(100);
        emit log(res);
    }
}

