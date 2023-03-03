
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Enum{
    enum State {Inactive,Active}

    State public state = State.Inactive;

    function activate() public{
        state = State.Active;
    }

    function deactivate() public{
        state = State.Inactive;
    }
}