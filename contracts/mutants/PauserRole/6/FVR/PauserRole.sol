pragma solidity ^0.4.24;

import "../Roles.sol";

contract PauserRole {
  using Roles for Roles.Role;

  event PauserAdded(address indexed account);
  event PauserRemoved(address indexed account);

  Roles.Role private pausers;

  constructor() public {
    _addPauser(msg.sender);
  }

  modifier onlyPauser() {
    require(isPauser(msg.sender));
    _;
  }

  function isPauser(address account) external view returns (bool) {
    return pausers.has(account);
  }

  function addPauser(address account) external onlyPauser {
    _addPauser(account);
  }

  function renouncePauser() external {
    _removePauser(msg.sender);
  }

  function _addPauser(address account) public {
    pausers.add(account);
    emit PauserAdded(account);
  }

  function _removePauser(address account) public {
    pausers.remove(account);
    emit PauserRemoved(account);
  }
}
