
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract StructTypes {
    struct Student{
        uint256 id;
        uint256 score;
    }
    Student student;
    function initStudent() external{
        student.id = 100;
        student.score = 200;
        Student storage _student = student;
        // Student memory _student = student;
        _student.id = 8;
        _student.score = 9;
    }
}
