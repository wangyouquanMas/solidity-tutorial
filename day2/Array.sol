// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

contract Counter {
//   string count = "ABDC";
//   function query_length() public returns (uint){
//       return count.length;
//   }
//   function query_index() public returns (bytes1){
//       return count[1];
//   }

  bytes count = "ABDC";
  function query_length() public returns (uint){
      return count.length;
  }
  function query_index() public returns (bytes1){
      return count[1];
  }
}