// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.8.7;

import {IAaveIncentivesController} from '../../interfaces/IAaveIncentivesController.sol';

contract MockIncentivesController is IAaveIncentivesController {
  

  

  

  

  function handleAction(
    address,
    uint256,
    uint256
  ) external override {}

  function getRewardsBalance(address[] calldata, address) external pure override returns (uint256) {
    return 0;
  }

  function claimRewards(
    address[] calldata,
    uint256,
    address
  ) external pure override returns (uint256) {
    return 0;
  }

  function claimRewardsOnBehalf(
    address[] calldata,
    uint256,
    address,
    address
  ) external pure override returns (uint256) {
    return 0;
  }

  function getUserUnclaimedRewards(address) external pure override returns (uint256) {
    return 0;
  }

  function getUserAssetData(address, address) external pure override returns (uint256) {
    return 0;
  }

  function REWARD_TOKEN() external pure override returns (address) {
    return address(0);
  }

  function PRECISION() external pure override returns (uint8) {
    return 0;
  }
}
