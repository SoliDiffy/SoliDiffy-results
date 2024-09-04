// SWC-103-Floating Pragma: L2
pragma solidity ^0.4.24;

import "../Roles.sol";

contract CapperRole {
  using Roles for Roles.Role;

  event CapperAdded(address indexed account);
  event CapperRemoved(address indexed account);

  Roles.Role private cappers;

  constructor() public {
    _addCapper(msg.sender);
  }

  modifier onlyCapper() {
    require(isCapper(msg.sender));
    _;
  }

  function isCapper(address account) external view returns (bool) {
    return cappers.has(account);
  }

  function addCapper(address account) external onlyCapper {
    _addCapper(account);
  }

  function renounceCapper() external {
    _removeCapper(msg.sender);
  }

  function _addCapper(address account) public {
    cappers.add(account);
    emit CapperAdded(account);
  }

  function _removeCapper(address account) public {
    cappers.remove(account);
    emit CapperRemoved(account);
  }
}
