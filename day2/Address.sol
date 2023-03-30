
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;


contract Primitives{
    event balance(address caller , uint amount); 
    event LogData(uint amount , uint gas,uint from);
   // address payable public addr = payable(0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c);

    address  public addr = 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c;
    function getBalance() public  payable  {
        emit balance(msg.sender,addr.balance);
    }


  // Fallback function must be declared as external.
    fallback() external payable {
        // send / transfer (forwards 2300 gas to this fallback function)
        // call (forwards all of the gas)
        // emit Log("fallback", gasleft());
        emit LogData(msg.value, gasleft(),1);
    }

    //当call 没有携带message用 receive 
     receive() external payable{
        emit LogData(msg.value, gasleft(),2);
    }

}


contract TransferETH {
        event transferLog(address sender, uint value);
    function transfer(address payable recipient) public payable {
        recipient.transfer(msg.value);
        emit transferLog(msg.sender, msg.value);
    }

     function send(address payable recipient) public payable returns (bool) {
       return  recipient.send(msg.value);
    }
    
        event gasLog(uint gas);
      function call(address payable recipient) public payable returns (bool) {
        //   emit gasLog(gasleft());
         (bool sent, )  = recipient.call{value: msg.value,gas:gasleft()}("abc");
          emit gasLog(gasleft());
         return sent ; 
    }
    
    event depositLog(address sender, uint value);
    function deposit() public payable{
         emit depositLog(msg.sender, msg.value);   
    }

}