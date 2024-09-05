pragma solidity ^0.4.24;

import "../access/roles/PauserRole.sol";

contract PauserRoleMock is PauserRole {
  function removePauser(address account) external {
    _removePauser(account);
  }

  function onlyPauserMock() external view onlyPauser {
  }

  // Causes a compilation error if super._removePauser is not internal
  function _removePauser(address account) public {
    super._removePauser(account);
  }
}
