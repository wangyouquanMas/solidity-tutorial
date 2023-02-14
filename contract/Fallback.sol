// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.6.2 <0.9.0;

contract Test{
    uint x;
    //无其它函数、 未用payable修饰【不能接收ether】
    fallback() external {x=1;}
}

contract TestPayable{
    uint x;
    uint y;

    //底层调用：no-empty call 、
    //非底层调用:消息 、
    fallback() external payable {x=1; y=msg.value;}

    //普通调用：send 
    // 非消息、 plain Ether transfer ; 
    //  empty call 
    receive() external payable{x=2 ; y=msg.value;}
}

contract Caller{
    function callTest(Test test) public returns (bool){
      (bool success,)  =   address(test).call(abi.encodeWithSignature("nonExistingFunction()"));
        require(success);


     address payable testPayable = payable(address(test));

    //无payable修饰
     return testPayable.send(2 ether);   
    }

    function callTestPayable(TestPayable test) public returns (bool){
        (bool success,) = address(test).call(abi.encodeWithSignature("nonExistingFunction("));
        require(success);


        (success,) = address(test).call{value: 1}(abi.encodeWithSignature("nonExistingFunction()"));
        require(success);


        (success,) = address(test).call{value: 2 ether}("");
        require(success);

        return true;
    }


}