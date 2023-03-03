pragma solidity ^0.8.17;

contract MyContract {
    address owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Only the contract owner can call this function.");
        _;
    }

    function doSomething() public onlyOwner {
        // do something
    }
}
