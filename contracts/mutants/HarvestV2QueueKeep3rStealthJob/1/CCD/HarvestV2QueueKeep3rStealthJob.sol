// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import './V2QueueKeep3rStealthJob.sol';

contract HarvestV2QueueKeep3rStealthJob is V2QueueKeep3rStealthJob {
  

  function workable(address _strategy) external view override returns (bool) {
    return _workable(_strategy);
  }

  function _workable(address _strategy) internal view override returns (bool) {
    return super._workable(_strategy);
  }

  function _strategyTrigger(address _strategy, uint256 _amount) internal view override returns (bool) {
    if (_amount == 0) return true; // Force harvest on amount 0
    return IBaseStrategy(_strategy).harvestTrigger(_amount);
  }

  function _work(address _strategy) internal override {
    IV2Keeper(v2Keeper).harvest(_strategy);
  }

  // Keep3r actions
  function work(address _strategy) external override notPaused onlyStealthRelayer returns (uint256 _credits) {
    address _keeper = IStealthRelayer(stealthRelayer).caller();
    _isKeeper(_keeper);
    _credits = _workInternal(_strategy);
    _paysKeeperAmount(_keeper, _credits);
  }
}
