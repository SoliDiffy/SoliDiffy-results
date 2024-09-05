// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import './V2Keep3rJob.sol';

import '../../interfaces/jobs/v2/IV2Keep3rPublicJob.sol';

abstract contract V2Keep3rPublicJob is V2Keep3rJob, IV2Keep3rPublicJob {
  

  // Mechanics keeper bypass
  function forceWork(address _strategy) external override onlyGovernorOrMechanic {
    _forceWork(_strategy);
  }
}
