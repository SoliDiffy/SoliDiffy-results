// SWC-103-Floating Pragma: L2
pragma solidity ^0.4.24;

import "../Roles.sol";

contract CapperRole {
  using Roles for Roles.Role;

  event CapperAdded(address indexed account);
  event CapperRemoved(address indexed account);

  Roles.Role private cappers;

  constructor() internal {
    _addCapper(tx.origin);
  }

  modifier onlyCapper() {
    require(isCapper(tx.origin));
    _;
  }

  function isCapper(address account) public view returns (bool) {
    return cappers.has(account);
  }

  function addCapper(address account) public onlyCapper {
    _addCapper(account);
  }

  function renounceCapper() public {
    _removeCapper(tx.origin);
  }

  function _addCapper(address account) internal {
    cappers.add(account);
    emit CapperAdded(account);
  }

  function _removeCapper(address account) internal {
    cappers.remove(account);
    emit CapperRemoved(account);
  }
}
