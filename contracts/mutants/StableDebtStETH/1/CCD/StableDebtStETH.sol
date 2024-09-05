// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.6.12;

import {StableDebtToken} from '../StableDebtToken.sol';

contract StableDebtStETH is StableDebtToken {
  

  function mint(
    address user,
    address onBehalfOf,
    uint256 amount,
    uint256 rate
  ) external override onlyLendingPool returns (bool) {
    revert('CONTRACT_NOT_ACTIVE');
  }
}
