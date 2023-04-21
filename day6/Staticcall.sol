pragma solidity ^0.8.17;
//staticcall
//功能： used here because we only want to read data from 'OtherContract' and not modify its state
//对比call：if we wanted to modify 'OtherContract''s state, we would use 'call' instead.
contract OtherContract{
    uint public data;

    function setData(uint _data) public{
        data = _data;
    }
    function getData() public view returns (uint){
        return data;
    }
}

contract MyContract{
    // address public otherContract;
    // constructor(address  _otherContract){
    //         otherContract = _otherContract;
    //     }
    function callOtherContract(address otherContract ) public view returns (uint){ 
        bytes memory input = abi.encodeWithSignature("getData()");
        // bytes memory output = new bytes(32);
       (bool success, bytes memory returnData) =  otherContract.staticcall(input);
        require(success,"External contract call failed");


        // assembly{
        // //gas : amount of gas to send to the sub context to execute. The gas that is not used by the sub context is returned to this one.
        // //address: the account which context to execute
        // //argsOffset: byte offset in the memory in bytes, the calldata of the sub context
        // //argsSize: byte size to copy(size of the calldata)
        // //retOffset: byte offset in the memory in bytes, where to store the return data of the sub context.
        // //retSize: byte size to copy (size of the return data).
        //   success :=staticcall(gas(),otherContract,input,768,output,0x20)
        // }


        return abi.decode(returnData,(uint));
    }
}