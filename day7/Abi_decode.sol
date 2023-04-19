pragma solidity ^0.8.0;
//abi encode & decode用法
contract Abi_decode{

    struct Person{
        string name;
        uint256 age;  
    }
    event personLog(Person person);
    function decodeData() public returns (Person memory){
       Person memory person = Person(
          "wang",
         28
       ) ;
       bytes memory data =   abi.encode(person);
       person =  abi.decode(data,(Person));

       emit personLog(person); 
    }

    function encodePerson(string memory name, uint256 age ) public pure returns (bytes memory) {
        Person memory person = Person(name,age);
        return abi.encode(person.name, person.age);
    } 
}