// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.6;

import "@yield-protocol/vault-interfaces/IOracle.sol";
import "@yield-protocol/vault-interfaces/IJoin.sol";
import "@yield-protocol/vault-interfaces/IFYTokenFactory.sol";
import "@yield-protocol/utils-v2/contracts/access/AccessControl.sol";
import "./FYToken.sol";


/// @dev The FYTokenFactory creates new FYToken instances.
contract FYTokenFactory is IFYTokenFactory, AccessControl {

  /// @dev Deploys a new fyToken.
  /// @return fyToken The fyToken address.
  
}