// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.17 and less than 0.9.0
pragma solidity ^0.8.17;

contract HelloWorld{
    string public greet = "Hello World";
    
    function greetIsCorrect() public returns (bool){
      return   Assert.equal(greet, "Hello World","greet is not correct");
    }
}