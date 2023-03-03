
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract StorageMemoryCalldata{
    //storage 
    uint[]  public arr = [100,200,300];
    event CalldataLog(uint[] data,uint[] drr);
    
    event StorageLog(uint[] _arr,uint[] arr);



    function foo(uint[] memory _arr) public{
     arr = _arr;

     arr[0] = 100;

     uint[] memory brr =_arr;

     brr[0] = 200;
    
 // creates a new reference
        uint[] memory crr = new uint[](2);
        crr[0] = 300;
        crr[1] = 400;
        // will NOT update `arr` on the contract storage
        arr = crr;

        emit StorageLog(_arr,arr);
    }

    //calldata修饰的变量不能被修改    
     function bar(uint[] calldata _arr) public {
        // creates a new reference
        uint[] memory drr = _arr;
        // will NOT update `_arr`
        drr[0] = 500;
    			
		emit CalldataLog(_arr,drr);
    }
		
}