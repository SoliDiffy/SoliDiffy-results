pragma solidity ^0.4.24;

import "../Roles.sol";

contract MinterRole {
  using Roles for Roles.Role;

  event MinterAdded(address indexed account);
  event MinterRemoved(address indexed account);

  Roles.Role private minters;

  constructor() public {
    _addMinter(msg.sender);
  }

  modifier onlyMinter() {
    require(isMinter(msg.sender));
    _;
  }

  function isMinter(address account) external view returns (bool) {
    return minters.has(account);
  }

  function addMinter(address account) external onlyMinter {
    _addMinter(account);
  }

  function renounceMinter() external {
    _removeMinter(msg.sender);
  }

  function _addMinter(address account) public {
    minters.add(account);
    emit MinterAdded(account);
  }

  function _removeMinter(address account) internal {
    minters.remove(account);
    emit MinterRemoved(account);
  }
}
