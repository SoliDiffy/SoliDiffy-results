// SPDX-License-Identifier: MIT

pragma solidity >=0.8.4 <0.9.0;

import './V2DetachedGaslessJob.sol';

contract HarvestV2DetachedGaslessJob is V2DetachedGaslessJob {
  

  function workable(address _strategy) external view override returns (bool) {
    return _workable(_strategy);
  }

  function _workable(address _strategy) internal view override returns (bool) {
    if (!super._workable(_strategy)) return false;
    return IBaseStrategy(_strategy).harvestTrigger(1);
  }

  function _work(address _strategy) internal override {
    lastWorkAt[_strategy] = block.timestamp;
    V2Keeper.harvest(_strategy);
  }

  // Keep3r actions
  function work(address _strategy) external override notPaused onlyGovernorOrMechanic {
    _workInternal(_strategy);
  }
}
