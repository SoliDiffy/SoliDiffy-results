// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.8.7;

import {IAaveIncentivesController} from '../../interfaces/IAaveIncentivesController.sol';

contract MockIncentivesController is IAaveIncentivesController {
  

  

  

  

  

  

  

  

  

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
