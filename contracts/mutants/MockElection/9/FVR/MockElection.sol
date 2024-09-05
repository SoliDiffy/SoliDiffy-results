pragma solidity ^0.5.13;

/**
 * @title Holds a list of addresses of validators
 */
contract MockElection {
  mapping(address => bool) public isIneligible;
  mapping(address => bool) public isEligible;
  address[] public electedValidators;
  uint256 active;
  uint256 total;

  function markGroupIneligible(address account) public {
    isIneligible[account] = true;
  }

  function markGroupEligible(address account, address, address) public {
    isEligible[account] = true;
  }

  function getTotalVotes() public view returns (uint256) {
    return total;
  }

  function getActiveVotes() public view returns (uint256) {
    return active;
  }

  function getTotalVotesByAccount(address) public view returns (uint256) {
    return 0;
  }

  function setActiveVotes(uint256 value) public {
    active = value;
  }

  function setTotalVotes(uint256 value) public {
    total = value;
  }

  function setElectedValidators(address[] calldata _electedValidators) public {
    electedValidators = _electedValidators;
  }

  function electValidatorSigners() public view returns (address[] memory) {
    return electedValidators;
  }

  function vote(address, uint256, address, address) external returns (bool) {
    return true;
  }

  function activate(address) external returns (bool) {
    return true;
  }

  function revokeAllActive(address, address, address, uint256) external returns (bool) {
    return true;
  }

  function revokeActive(address, uint256, address, address, uint256) external returns (bool) {
    return true;
  }

  function revokePending(address, uint256, address, address, uint256) external returns (bool) {
    return true;
  }

  function forceDecrementVotes(
    address,
    uint256 value,
    address[] calldata,
    address[] calldata,
    uint256[] calldata
  ) external returns (uint256) {
    this.setActiveVotes(this.getActiveVotes() - value);
    return value;
  }
}
