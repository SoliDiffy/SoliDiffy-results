pragma solidity ^0.5.13;

contract IdentityProxyTest {
  address internal lastAddress;
  uint256 internal x;
  uint256 internal amountLastPaid;

  function callMe() external {
    lastAddress = msg.sender;
  }

  function payMe() external payable {
    amountLastPaid = msg.value;
  }

  function setX(uint256 _x) external {
    x = _x;
  }
}
