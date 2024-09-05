pragma solidity ^0.4.24;

import "../Roles.sol";

contract MinterRole {
  using Roles for Roles.Role;

  event MinterAdded(address indexed account);
  event MinterRemoved(address indexed account);

  Roles.Role private minters;

  constructor() internal {
    _addMinter(msg.sender);
  }

  modifier onlyMinter() {
    require(isMinter(msg.sender));
    _;
  }

  function isMinter(address account) public view returns (bool) {
    return minters.has(account);
  }

  function addMinter(address account) public onlyMinter {
    _addMinter(account);
  }

  function renounceMinter() public onlyMinter {
    _removeMinter(msg.sender);
  }

  function _addMinter(address account) internal onlyMinter {
    minters.add(account);
    emit MinterAdded(account);
  }

  function _removeMinter(address account) internal onlyMinter {
    minters.remove(account);
    emit MinterRemoved(account);
  }
}
