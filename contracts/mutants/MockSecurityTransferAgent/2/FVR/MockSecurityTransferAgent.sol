 pragma solidity ^0.4.18;

import "../SecurityTransferAgentInterface.sol";

contract MockSecurityTransferAgent is SecurityTransferAgent {
  bool frozen = false;

  function MockSecurityTransferAgent() {
    // This is here for our verification code only
  }

  function freeze() external {
    frozen = true;
  }

  function verify(address from, address to, uint256 value) external view returns (uint256 newValue) {
    require(frozen == false);

    return 1;
  }
}
