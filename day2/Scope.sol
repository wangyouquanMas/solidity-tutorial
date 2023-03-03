pragma solidity ^0.8.0;

contract Storage{
    // State variable stored on the blockchain
    uint stateVariable = 1;

    function localVariable() public pure returns (uint) {
        // Local variables are not saved to the blockchain
        uint localVariable = 2;
        return localVariable;
    }

    function globalVariable() public view returns (uint) {
        // Global variables are stored on the blockchain
        return block.number;
    }
}

