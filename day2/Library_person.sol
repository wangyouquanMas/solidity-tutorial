
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;
import "./Interface_storage.sol";

library  Library_person
{
    struct Person{
        string name;
        uint age;
        string gender;
        Interface_storage interface_storage;
    }
}