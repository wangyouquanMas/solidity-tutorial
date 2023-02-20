
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

//场景：需要将一个合约部署多次，可以使用代理合约来做节省成本【gas】


contract MinimalProxy{
    function clone(address target) external returns (address result){
        bytes20 targetBytes = bytes20(target);

        
    }

}
