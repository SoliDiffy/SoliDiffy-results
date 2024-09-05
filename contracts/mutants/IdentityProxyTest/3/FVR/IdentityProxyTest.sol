pragma solidity ^0.5.13;

contract IdentityProxyTest {
  address public lastAddress;
  uint256 public x;
  uint256 public amountLastPaid;

  function callMe() public {
    lastAddress = msg.sender;
  }

  function payMe() public payable {
    amountLastPaid = msg.value;
  }

  function setX(uint256 _x) public {
    x = _x;
  }
}
