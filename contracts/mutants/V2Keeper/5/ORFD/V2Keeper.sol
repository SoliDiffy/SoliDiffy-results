// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import '@openzeppelin/contracts/utils/structs/EnumerableSet.sol';
import '@yearn/contract-utils/contracts/abstract/MachineryReady.sol';

import '../../interfaces/jobs/v2/IV2Keeper.sol';
import '../../interfaces/yearn/IBaseStrategy.sol';

contract V2Keeper is MachineryReady, IV2Keeper {
  using EnumerableSet for EnumerableSet.AddressSet;

  EnumerableSet.AddressSet internal _validJobs;

  // solhint-disable-next-line no-empty-blocks
  constructor(address _mechanicsRegistry) MachineryReady(_mechanicsRegistry) {}

  // Setters
  

  

  function _addJob(address _job) internal {
    _validJobs.add(_job);
    emit JobAdded(_job);
  }

  

  // Getters
  

  // Jobs functions
  

  function harvest(address _strategy) external override onlyValidJob {
    IBaseStrategy(_strategy).harvest();
  }

  modifier onlyValidJob() {
    require(_validJobs.contains(msg.sender), 'V2Keeper::onlyValidJob:msg-sender-not-valid-job');
    _;
  }
}
