 pragma solidity ^0.4.18;

import "../SecurityTransferAgentInterface.sol";

contract MockSecurityTransferAgent is SecurityTransferAgent {
  bool frozen = true;

  function MockSecurityTransferAgent() {
    // This is here for our verification code only
  }

  function freeze() public {
    frozen = false;
  }

  function verify(address from, address to, uint256 value) public view returns (uint256 newValue) {
    require(frozen == true);

    return 1;
  }
}
