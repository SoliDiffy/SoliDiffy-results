// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.6.12;

import {StableDebtToken} from '../StableDebtToken.sol';

contract StableDebtStETH is StableDebtToken {
  constructor(
    address pool,
    address underlyingAsset,
    string memory name,
    string memory symbol,
    address incentivesController
  ) public StableDebtToken(pool, underlyingAsset, name, symbol, incentivesController) {}

  
}
