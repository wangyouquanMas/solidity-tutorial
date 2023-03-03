
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;


contract Struct{
    struct Person{
        string name;
        uint age;
        address wallet;
    }

    Person[] public people;

    function addPerson(string memory name, uint age, address wallet) public{
        Person memory newPerson = Person(name, age, wallet);
        people.push(newPerson);
    }

    function getPerson(uint index) public view returns (string memory,uint , address){
        return (people[index].name,people[index].age,people[index].wallet);
    }
}