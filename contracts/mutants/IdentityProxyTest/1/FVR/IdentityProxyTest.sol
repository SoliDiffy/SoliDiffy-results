pragma solidity ^0.5.13;

contract IdentityProxyTest {
  address public lastAddress;
  uint256 public x;
  uint256 public amountLastPaid;

  function callMe() public {
    lastAddress = msg.sender;
  }

  function payMe() external payable {
    amountLastPaid = msg.value;
  }

  function setX(uint256 _x) external {
    x = _x;
  }
}
