// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./Interface_storage.sol";

library Storage_library{
    function test_storage(Interface_storage.Person storage person,uint amount) internal returns (uint){
        return amount;
    }
}