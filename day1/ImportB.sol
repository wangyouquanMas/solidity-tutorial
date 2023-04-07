// A.sol
pragma solidity ^0.8.7;

import "./B.sol";
//部署A合约时，B合约的代码也会被部署，因为它们被一起编译。
//因此，不需要单独部署B合约。
contract A {
    B private b;

    constructor() {
        b = new B(); // 创建B合约的实例
    }

    function getSomething() public view returns (uint) {
        return b.doSomething(); // 调用B合约的方法
    }
}
