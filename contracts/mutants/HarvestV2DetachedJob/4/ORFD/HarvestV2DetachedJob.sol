// SPDX-License-Identifier: MIT

pragma solidity >=0.8.4 <0.9.0;

import './V2DetachedJob.sol';

contract HarvestV2DetachedJob is V2DetachedJob {
  constructor(
    address _baseFeeOracle,
    address _mechanicsRegistry,
    address _yOracle,
    address _v2Keeper,
    uint256 _workCooldown
  )
    V2DetachedJob(_baseFeeOracle, _mechanicsRegistry, _yOracle, _v2Keeper, _workCooldown) // solhint-disable-next-line no-empty-blocks
  {}

  

  

  

  // Keep3r actions
  
}
