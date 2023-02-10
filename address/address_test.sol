pragma solidity ^0.8.0;

contract AddressExample {
    address payable owner;

    constructor() public {
        owner =  payable(<msg.sender>);
    }

    function getOwner() public view returns (address payable) {
        return owner;
    }

    function transfer(address payable _to, uint256 _value) public {
        require(msg.sender == owner, "Only owner can transfer funds");
        _to.transfer(_value);
    }
}
