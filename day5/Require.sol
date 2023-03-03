pragma solidity ^0.8.17;

contract MyContract {
    mapping(address => uint) balances;

    function transfer(address to, uint amount) public {
        // 检查调用者的余额是否足够
        require(balances[msg.sender] >= amount, "Insufficient balance.");

        // 检查转移数量是否为正数
        require(amount > 0, "Amount must be greater than zero.");

        // 转移代币
        balances[msg.sender] -= amount;
        balances[to] += amount;
    }
}
