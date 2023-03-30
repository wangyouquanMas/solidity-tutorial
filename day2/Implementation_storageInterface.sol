
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;
import "./Interface_storage.sol";
contract Implementation_storage is Interface_storage{
      function test_storage(uint amount) external override  returns (bool){
          return amount >0?true:false;
      }

}