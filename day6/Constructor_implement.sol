pragma solidity ^0.8.17;

contract B {
    uint public x;

    constructor(uint _x) {
        x = _x;
    }
}
//构造器继承方式1
// contract A is B(1) {
  
// }

//构造器继承方式2
contract A is B {
  constructor(uint _c) B(_c){}
}
