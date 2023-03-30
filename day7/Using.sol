pragma solidity ^0.8.0;

//using for用法详解

library SafeMath {
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");
        return c;
    }

    function sub(uint8 a, uint8 b) internal pure returns (uint8) {
        require(b <= a, "SafeMath: subtraction overflow");
        uint8 c = a - b;
        return c;
    }
}

contract MyContract {
    using SafeMath for uint256;
    using SafeMath for uint8;

    uint256 public myNumber;
    uint8 public myNumber1;

    function myFunction(uint256 value) public {
        myNumber = myNumber.add(value);
    }
    
    // Member "sub" not found or not visible after argument-dependent lookup in uint256
    function sub(uint8 value) public {
        myNumber1 = myNumber1.sub(value);
    }
}
