// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// 基本接口
interface IGreeter {
    function greet() external view returns (string memory);
}

// 实现接口的具体合约A
contract GreeterA is IGreeter {
    function greet() external view override returns (string memory) {
        return "Hello from GreeterA!";
    }
}

// 实现接口的具体合约B
contract GreeterB is IGreeter {
    function greet() external view override returns (string memory) {
        return "Hello from GreeterB!";
    }
}

// 代理合约
contract GreeterProxy {
    address public implementation;

    constructor(address _implementation) {
        implementation = _implementation;
    }

    function setImplementation(address _implementation) external {
        implementation = _implementation;
    }

    function greet() external view returns (string memory) {
        //IGreeter.greet.selector用于获取greet函数在IGreeter接口中的方法选择器。
        //用于构建用于调用目标实现合约的ABI编码数据
        bytes4 selector = IGreeter.greet.selector;
        bytes memory data = abi.encodeWithSelector(selector);
        //代理合约将使用此方法选择器与实现合约进行交互
        //以便正确调用greet函数并获取返回值。 
        (bool success, bytes memory result) = implementation.staticcall(data);
        require(success, "Failed to call greet function");

        return abi.decode(result, (string));
    }
}
