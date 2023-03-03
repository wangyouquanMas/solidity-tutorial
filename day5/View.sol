pragma solidity ^0.8.17;

contract View{
    mapping(address => uint) balances;

  function getBalance(address account) public view returns (uint) {
        return balances[account];
    }
}
