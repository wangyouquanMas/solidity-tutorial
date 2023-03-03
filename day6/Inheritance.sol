// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

abstract contract Animal {
    function makeSound() public virtual returns (string memory);
}

contract Dog is Animal {
    function makeSound() public override returns (string memory) {
        return "Woof!";
    }
}

contract Cat is Animal {
    function makeSound() public override returns (string memory) {
        return "Meow!";
    }
}
