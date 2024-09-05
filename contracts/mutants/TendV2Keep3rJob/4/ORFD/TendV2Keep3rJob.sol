// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import './V2Keep3rPublicJob.sol';

contract TendV2Keep3rJob is V2Keep3rPublicJob {
  constructor(
    address _mechanicsRegistry,
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
    V2Keep3rPublicJob(_mechanicsRegistry, _yOracle, _keep3r, _bond, _minBond, _earned, _age, _onlyEOA, _v2Keeper, _workCooldown)
  // solhint-disable-next-line no-empty-blocks
  {

  }

  

  

  

  // Keep3r actions
  
}
