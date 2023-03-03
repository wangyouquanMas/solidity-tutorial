pragma solidity ^0.8.17;

contract MyContract {
    // 定义一个名为“Error”的错误类型
    Error error(string reason);

    // 定义一个名为“add”的函数
    function add(uint a, uint b) public returns (uint) {
        uint c = a + b;

        // 如果计算结果小于a，则抛出自定义错误类型
        if (c < a) {
            revert Error("Addition overflow");
        }

        return c;
    }
}
