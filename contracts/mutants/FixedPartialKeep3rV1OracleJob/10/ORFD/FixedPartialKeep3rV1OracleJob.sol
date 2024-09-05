// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;

import '@openzeppelin/contracts/math/SafeMath.sol';
import '@yearn/contract-utils/contracts/abstract/UtilsReady.sol';
import '@yearn/contract-utils/contracts/keep3r/Keep3rAbstract.sol';
import '../../utils/GasPriceLimited.sol';

import '../../interfaces/jobs/IKeep3rJob.sol';
import '../../interfaces/oracle/IOracleBondedKeeper.sol';
import '../../interfaces/oracle/IPartialKeep3rV1OracleJob.sol';

contract FixedPartialKeep3rV1OracleJob is UtilsReady, Keep3r, IPartialKeep3rV1OracleJob {
  using SafeMath for uint256;

  uint256 public constant PRECISION = 1_000;
  uint256 public constant MAX_REWARD_MULTIPLIER = 1 * PRECISION; // 1x max reward multiplier
  uint256 public override rewardMultiplier = MAX_REWARD_MULTIPLIER;

  EnumerableSet.AddressSet internal _availablePairs;

  address public immutable override oracleBondedKeeper = 0xA8646cE5d983E996EbA22eb39e5956653ec63762;

  // 0x1cEB5cB57C4D4E2b2433641b95Dd330A33185A44 = Keep3rV1

  constructor() public UtilsReady() Keep3r(0x1cEB5cB57C4D4E2b2433641b95Dd330A33185A44) {
    _setKeep3rRequirements(0x1cEB5cB57C4D4E2b2433641b95Dd330A33185A44, 200 ether, 0, 0, false);
  }

  // Keep3r Setters
  

  

  

  function _setRewardMultiplier(uint256 _rewardMultiplier) internal {
    require(_rewardMultiplier <= MAX_REWARD_MULTIPLIER, 'FixedPartialKeep3rV1OracleJob::set-reward-multiplier:multiplier-exceeds-max');
    rewardMultiplier = _rewardMultiplier;
  }

  // Setters
  

  

  function _addPair(address _pair) internal {
    require(!_availablePairs.contains(_pair), 'FixedPartialKeep3rV1OracleJob::add-pair:pair-already-added');
    _availablePairs.add(_pair);
    emit PairAdded(_pair);
  }

  

  // Getters
  

  // Keeper view actions
  

  function _workable(address _pair) internal view returns (bool) {
    require(_availablePairs.contains(_pair), 'FixedPartialKeep3rV1OracleJob::workable:pair-not-found');
    return IOracleBondedKeeper(oracleBondedKeeper).workable(_pair);
  }

  // Keeper actions
  function _work(address _pair) internal returns (uint256 _credits) {
    uint256 _initialGas = gasleft();

    require(_workable(_pair), 'FixedPartialKeep3rV1OracleJob::work:not-workable');

    require(_updatePair(_pair), 'FixedPartialKeep3rV1OracleJob::work:pair-not-updated');

    _credits = _calculateCredits(_initialGas);

    emit Worked(_pair, msg.sender, _credits);
  }

  

  function _calculateCredits(uint256 _initialGas) internal view returns (uint256 _credits) {
    // Gets default credits from KP3R_Helper and applies job reward multiplier
    return _getQuoteLimitFor(msg.sender, _initialGas).mul(rewardMultiplier).div(PRECISION);
  }

  // Mechanics keeper bypass
  

  function _updatePair(address _pair) internal returns (bool _updated) {
    return IOracleBondedKeeper(oracleBondedKeeper).updatePair(_pair);
  }
}
