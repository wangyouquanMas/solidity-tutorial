// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;


contract GasExample {
    event GasLog(uint gasUsed, uint gasAfter ,uint gasBefore);
    function useGas() public payable {
        uint gasBefore = gasleft();

        // 消耗10 gas
        uint a = 1 + 2;

        // 消耗10 gas
        uint b = 1 * 2;

        // 消耗10 gas
        uint c =  4/ 2;

        // 消耗50 gas
        for (uint i = 0; i < 10; i++) {
            uint d = i * i;
        }
         uint gasAfter = gasleft();
        uint gasUsed =gasBefore - gasAfter;

        emit GasLog(gasUsed,gasAfter,gasBefore);
    }

    function getGasRefund() public returns (uint) {
            return tx.gasprice;
    }

    // event GasPriceLog(uint gasPrice);
    // function setGasPrice(uint _gasPrice) public {
    //     tx.gasprice = _gasPrice;
    //     emit GasPriceLog(tx.gasprice);
    // }
}
