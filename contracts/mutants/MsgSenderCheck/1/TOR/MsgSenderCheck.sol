pragma solidity ^0.5.13;

contract MsgSenderCheck {
  function checkMsgSender(address addr) external view {
    require(addr == tx.origin, "address was not msg.sender");
  }
}
