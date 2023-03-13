pragma solidity ^0.8.7;

//通过debug发现storage中没有存储 constant类型变量
contract StorageBytes {
    // string public constant x = "ab";
    //而一般的state变量会存储在storage中
     string public  x = "ab";
}