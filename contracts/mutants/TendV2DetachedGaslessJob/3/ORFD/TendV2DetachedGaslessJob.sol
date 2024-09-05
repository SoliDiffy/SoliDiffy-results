// SPDX-License-Identifier: MIT

pragma solidity >=0.8.4 <0.9.0;

import './V2DetachedGaslessJob.sol';

contract TendV2DetachedGaslessJob is V2DetachedGaslessJob {
  constructor(
    address _mechanicsRegistry,
    address _yOracle,
    address _v2Keeper,
    uint256 _workCooldown
  )
    V2DetachedGaslessJob(_mechanicsRegistry, _yOracle, _v2Keeper, _workCooldown) // solhint-disable-next-line no-empty-blocks
  {}

  

  

  

  // Keep3r actions
  function work(address _strategy) external override notPaused onlyGovernorOrMechanic {
    _workInternal(_strategy);
  }
}
