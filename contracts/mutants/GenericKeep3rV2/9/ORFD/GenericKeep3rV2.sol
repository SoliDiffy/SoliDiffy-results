// SPDX-License-Identifier: MIT

pragma solidity >=0.6.8;

import '@openzeppelin/contracts/math/SafeMath.sol';
import '@openzeppelin/contracts/utils/EnumerableSet.sol';

import '../interfaces/Keep3r/IStrategyKeep3r.sol';
import '../interfaces/yearn/IBaseStrategy.sol';
import '../interfaces/keep3r/IKeep3rV1Helper.sol';
import '../interfaces/keep3r/IUniswapV2SlidingOracle.sol';

import './Keep3rAbstract.sol';

contract GenericKeep3rV2 is Governable, CollectableDust, Keep3r, IStrategyKeep3r {
  using SafeMath for uint256;

  EnumerableSet.AddressSet internal availableStrategies;
  mapping(address => uint256) public requiredHarvest;
  mapping(address => uint256) public requiredTend;
  address public keep3rHelper;
  address public slidingOracle;

  address public constant KP3R = address(0x1cEB5cB57C4D4E2b2433641b95Dd330A33185A44);
  address public constant WETH = address(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);

  constructor(
    address _keep3r,
    address _keep3rHelper,
    address _slidingOracle
  ) public Governable(msg.sender) CollectableDust() Keep3r(_keep3r) {
    keep3rHelper = _keep3rHelper;
    slidingOracle = _slidingOracle;
  }

  // Unique method to add a strategy to the system
  // If you don't require harvest, use _requiredHarvest = 0
  // If you don't require tend, use _requiredTend = 0
  

  function _addHarvestStrategy(address _strategy, uint256 _requiredHarvest) internal {
    require(requiredHarvest[_strategy] == 0, 'generic-keep3r-v2::add-harvest-strategy:strategy-already-added');
    _setRequiredHarvest(_strategy, _requiredHarvest);
    emit HarvestStrategyAdded(_strategy, _requiredHarvest);
  }

  function _addTendStrategy(address _strategy, uint256 _requiredTend) internal {
    require(requiredTend[_strategy] == 0, 'generic-keep3r-v2::add-tend-strategy:strategy-already-added');
    _setRequiredTend(_strategy, _requiredTend);
    emit TendStrategyAdded(_strategy, _requiredTend);
  }

  

  

  

  

  function _setRequiredHarvest(address _strategy, uint256 _requiredHarvest) internal {
    require(_requiredHarvest > 0, 'generic-keep3r-v2::set-required-harvest:should-not-be-zero');
    requiredHarvest[_strategy] = _requiredHarvest;
  }

  function _setRequiredTend(address _strategy, uint256 _requiredTend) internal {
    require(_requiredTend > 0, 'generic-keep3r-v2::set-required-tend:should-not-be-zero');
    requiredTend[_strategy] = _requiredTend;
  }

  // Getters
  

  

  

  

  // Keep3r actions
  function harvest(address _strategy) external override paysKeeper {
    require(harvestable(_strategy), 'generic-keep3r-v2::harvest:not-workable');
    _harvest(_strategy);
    emit HarvestedByKeeper(_strategy);
  }

  function tend(address _strategy) external override paysKeeper {
    require(tendable(_strategy), 'generic-keep3r-v2::tend:not-workable');
    _tend(_strategy);
    emit TendedByKeeper(_strategy);
  }

  function _harvest(address _strategy) internal {
    IBaseStrategy(_strategy).harvest();
  }

  function _tend(address _strategy) internal {
    IBaseStrategy(_strategy).tend();
  }

  // Governable
  function setPendingGovernor(address _pendingGovernor) external override onlyGovernor {
    _setPendingGovernor(_pendingGovernor);
  }

  function acceptGovernor() external override onlyPendingGovernor {
    _acceptGovernor();
  }

  // Collectable Dust
  function sendDust(
    address _to,
    address _token,
    uint256 _amount
  ) external override onlyGovernor {
    _sendDust(_to, _token, _amount);
  }
}
