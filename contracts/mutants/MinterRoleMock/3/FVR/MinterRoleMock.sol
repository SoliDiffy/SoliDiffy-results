pragma solidity ^0.4.24;

import "../access/roles/MinterRole.sol";

contract MinterRoleMock is MinterRole {
  function removeMinter(address account) external {
    _removeMinter(account);
  }

  function onlyMinterMock() external view onlyMinter {
  }

  // Causes a compilation error if super._removeMinter is not internal
  function _removeMinter(address account) public {
    super._removeMinter(account);
  }
}
