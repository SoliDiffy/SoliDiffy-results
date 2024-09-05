// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import './V2Keep3rStealthJob.sol';

contract HarvestV2Keep3rStealthJob is V2Keep3rStealthJob {
  

  function workable(address _strategy) external view override returns (bool) {
    return _workable(_strategy);
  }

  function _workable(address _strategy) internal view override returns (bool) {
    if (!super._workable(_strategy)) return false;
    return IBaseStrategy(_strategy).harvestTrigger(_getCallCosts(_strategy));
  }

  function _work(address _strategy) internal override {
    lastWorkAt[_strategy] = block.timestamp;
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
