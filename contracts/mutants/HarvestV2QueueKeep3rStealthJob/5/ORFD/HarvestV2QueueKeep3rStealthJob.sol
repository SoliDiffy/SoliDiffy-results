// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import './V2QueueKeep3rStealthJob.sol';

contract HarvestV2QueueKeep3rStealthJob is V2QueueKeep3rStealthJob {
  constructor(
    address _mechanicsRegistry,
    address _stealthRelayer,
    address _yOracle,
    address _keep3r,
    address _bond,
    uint256 _minBond,
    uint256 _earned,
    uint256 _age,
    bool _onlyEOA,
    address _v2Keeper,
    uint256 _workCooldown
  )
    V2QueueKeep3rStealthJob(
      _mechanicsRegistry,
      _stealthRelayer,
      _yOracle, /*TODO:_yOracle*/
      _keep3r,
      _bond,
      _minBond,
      _earned,
      _age,
      _onlyEOA,
      _v2Keeper,
      _workCooldown
    )
  // solhint-disable-next-line no-empty-blocks
  {

  }

  

  

  

  

  // Keep3r actions
  
}
