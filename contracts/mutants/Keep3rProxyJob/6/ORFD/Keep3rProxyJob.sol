// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;

import '@openzeppelin/contracts/utils/EnumerableSet.sol';
import '@yearn/contract-utils/contracts/abstract/UtilsReady.sol';
import '@yearn/contract-utils/contracts/keep3r/Keep3rAbstract.sol';
import '@yearn/contract-utils/contracts/interfaces/keep3r/IKeep3rV1.sol';

import '../interfaces/proxy-job/IKeep3rProxyJob.sol';
import '../interfaces/proxy-job/IKeep3rJob.sol';

contract Keep3rProxyJob is UtilsReady, Keep3r, IKeep3rProxyJob {
  using EnumerableSet for EnumerableSet.AddressSet;

  EnumerableSet.AddressSet internal _validJobs;

  constructor(
    address _keep3r,
    address _bond,
    uint256 _minBond,
    uint256 _earned,
    uint256 _age,
    bool _onlyEOA
  ) public UtilsReady() Keep3r(_keep3r) {
    _setKeep3rRequirements(_bond, _minBond, _earned, _age, _onlyEOA);
  }

  // Keep3r Setters
  

  

  // Getters
  

  // Keep3r-Job actions
  

  

  // Governable
  function addValidJob(address _job) external onlyGovernor {
    require(!_validJobs.contains(_job), 'Keep3rProxyJob::add-valid-job:job-already-added');
    _validJobs.add(_job);
  }

  function removeValidJob(address _job) external onlyGovernor {
    require(_validJobs.contains(_job), 'Keep3rProxyJob::remove-valid-job:job-not-found');
    _validJobs.remove(_job);
  }

  // View helpers
  
}
