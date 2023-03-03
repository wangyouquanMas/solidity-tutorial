pragma solidity ^0.8.17;

contract Internal{
    mapping(address => uint) balances;

    function _getBalance(address account) internal view returns (uint){
        return balances[account];
    }

    // function _getBalance(address account) private view returns (uint){
    //     return balances[account];
    // }
}

contract Internal2 is Internal{
    function getBalance(address account) public view returns (uint){
        return _getBalance(account);
    }
}