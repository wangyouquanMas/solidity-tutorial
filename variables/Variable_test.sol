pragma solidity ^0.8.0;
//目的：验证message.sender是谁
//      是函数调用者。在本例中是由0x5B38Da6a701c568545dCfcB03FcB875f56beddC4调用Variables合约中的checkSnder函数。 
contract Variables {
    string public text = "Hello";
    uint public num = 123;
    address public constant sender = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
//1 assert要放在函数中
//2 相等判断 ==
//3 

    uint public balance;

    function checkSender() public view returns(bool) {
        assert(msg.sender == sender);
        return true;
    }

    function deposit() payable public {
        balance +=msg.value;
    }

      function test()  payable public returns (uint){
        // assert(msg.value == 1000);
        return msg.value;
    }
}
