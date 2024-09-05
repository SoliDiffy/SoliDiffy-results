// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import './V2Keep3rPublicJob.sol';

contract TendV2Keep3rJob is V2Keep3rPublicJob {
  

  function workable(address _strategy) external view override returns (bool) {
    return _workable(_strategy);
  }

  function _workable(address _strategy) internal view override returns (bool) {
    if (!super._workable(_strategy)) return false;
    return IBaseStrategy(_strategy).tendTrigger(_getCallCosts(_strategy));
  }

  function _work(address _strategy) internal override {
    lastWorkAt[_strategy] = block.timestamp;
    IV2Keeper(v2Keeper).tend(_strategy);
  }

  // Keep3r actions
  function work(address _strategy) external override notPaused onlyKeeper(msg.sender) returns (uint256 _credits) {
    _credits = _workInternal(_strategy);
    _paysKeeperAmount(msg.sender, _credits);
  }
}
