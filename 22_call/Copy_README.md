Solidity 中的 call() 函数
在 Solidity 中，call() 是一个函数，它可以用来调用另一个合约的函数。通常用于与智能合约交互或在智能合约之间进行交互。call() 函数返回布尔值，指示是否成功执行了函数调用。

语法
solidity
Copy code
(bool success, bytes memory returnData) = address.call(bytes memory data);
address 表示要调用的合约的地址。 data 是要传递给合约函数的参数。

success 是一个布尔值，指示函数调用是否成功执行。

returnData 是一个字节数组，包含从被调用合约返回的数据。

用法示例
solidity
Copy code
pragma solidity ^0.8.0;

contract Caller {
    function callHelloWorld(address _helloWorldAddress) public returns (bool, bytes memory) {
        bytes memory payload = abi.encodeWithSignature("sayHello()");
        (bool success, bytes memory returnData) = _helloWorldAddress.call(payload);
        return (success, returnData);
    }
}

contract HelloWorld {
    function sayHello() public pure returns (string memory) {
        return "Hello, world!";
    }
}
在这个例子中，Caller 合约包含一个名为 callHelloWorld 的函数，该函数可以调用 HelloWorld 合约的 sayHello 函数。函数 callHelloWorld 接受一个 HelloWorld 合约的地址，使用 abi.encodeWithSignature 函数编码 sayHello 函数的签名，然后使用 call() 函数来调用 HelloWorld 合约的函数。call() 函数返回一个布尔值，指示函数调用是否成功执行，并且返回从被调用合约返回的数据。