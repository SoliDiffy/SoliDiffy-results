// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;

import '@openzeppelin/contracts/utils/EnumerableSet.sol';
import '@yearn/contract-utils/contracts/abstract/UtilsReady.sol';
import '@yearn/contract-utils/contracts/interfaces/keep3r/IKeep3rV1.sol';

import '../../interfaces/keep3r/IUniswapV2SlidingOracle.sol';
import '../../interfaces/oracle/IOracleBondedKeeper.sol';

contract OracleBondedKeeper is UtilsReady, IOracleBondedKeeper {
  using EnumerableSet for EnumerableSet.AddressSet;

  EnumerableSet.AddressSet internal _validJobs;

  address public immutable override keep3r;
  address public immutable override keep3rV1Oracle;

  constructor(address _keep3r, address _keep3rV1Oracle) public UtilsReady() {
    keep3r = _keep3r;
    keep3rV1Oracle = _keep3rV1Oracle;
  }

  // Setters
  

  

  function _addJob(address _job) internal {
    _validJobs.add(_job);
    emit JobAdded(_job);
  }

  

  // Getters
  

  // Jobs functions
  

  

  modifier onlyValidJob() {
    require(_validJobs.contains(msg.sender), 'OracleBondedKeeper::onlyValidJob:msg-sender-not-valid-job');
    _;
  }

  // Governor Keeper Bond
  

  

  

  function withdraw(address _bonding) external override onlyGovernor {
    IKeep3rV1(keep3r).withdraw(_bonding);
  }
}
