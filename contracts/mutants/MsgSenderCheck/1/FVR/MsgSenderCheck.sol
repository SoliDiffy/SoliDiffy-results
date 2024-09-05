pragma solidity ^0.5.13;

contract MsgSenderCheck {
  function checkMsgSender(address addr) public view {
    require(addr == msg.sender, "address was not msg.sender");
  }
}
