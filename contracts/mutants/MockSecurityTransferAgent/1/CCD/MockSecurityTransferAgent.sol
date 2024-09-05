 pragma solidity ^0.4.18;

import "../SecurityTransferAgentInterface.sol";

contract MockSecurityTransferAgent is SecurityTransferAgent {
  bool frozen = false;

  

  function freeze() public {
    frozen = true;
  }

  function verify(address from, address to, uint256 value) public view returns (uint256 newValue) {
    require(frozen == false);

    return 1;
  }
}
