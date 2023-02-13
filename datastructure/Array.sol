// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Array{
    uint[] public arr;
    uint[] public arr2 = [1,2,3];

    uint[10] public myFixedSizeArr;


    // Solidity can return the entire array.
    // But this function should be avoided for
    // arrays that can grow indefinitely in length.
    function getArr() public view returns (uint[] memory) {
        return arr;
    }

      function push(uint i) public {
        // Append to array
        // This will increase the array length by 1.
        arr.push(i);
    }
    
     function pop() public {
        // Remove last element from array
        // This will decrease the array length by 1
        arr.pop();
    }

      function getLength() public view returns (uint) {
        return arr.length;
    }

    
    function remove(uint index) public {
        // Delete does not change the array length.
        // It resets the value at index to it's default value,
        // in this case 0
        delete arr[index];
    }

     function examples() external {
        // create array in memory, only fixed size can be created
        uint[] memory a = new uint[](5);
    }

}

 