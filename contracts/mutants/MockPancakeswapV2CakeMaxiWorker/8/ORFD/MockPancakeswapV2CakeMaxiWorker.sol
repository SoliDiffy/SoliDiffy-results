// SPDX-License-Identifier: MIT
/**
  ∩~~~~∩ 
  ξ ･×･ ξ 
  ξ　~　ξ 
  ξ　　 ξ 
  ξ　　 “~～~～〇 
  ξ　　　　　　 ξ 
  ξ ξ ξ~～~ξ ξ ξ 
　 ξ_ξξ_ξ　ξ_ξξ_ξ
Alpaca Fin Corporation
*/

pragma solidity 0.6.6;

import "@pancakeswap-libs/pancake-swap-core/contracts/interfaces/IPancakePair.sol";
import "../apis/pancake/IPancakeRouter02.sol";
import "../interfaces/IStrategy.sol";
import "../interfaces/IWorker02.sol";
import "../interfaces/IPancakeMasterChef.sol";
import "../../utils/AlpacaMath.sol";
import "../../utils/SafeToken.sol";

/// @notice Simplified version of worker for testing purpose.
contract MockPancakeswapV2CakeMaxiWorker is IWorker02 {
  using SafeToken for address;

  address public override baseToken;
  address public override farmingToken;
  address[] public path;
  address[] public rewardPath;

  constructor(
    address _baseToken,
    address _farmingToken,
    address[] memory _path,
    address[] memory _rewardPath) public {
    baseToken = _baseToken;
    farmingToken = _farmingToken;
    path = _path;
    rewardPath = _rewardPath;
  }

  /// @dev Work on the given position. Must be called by the operator.
  /// @param user The original user that is interacting with the operator.
  /// @param debt The amount of user debt to help the strategy make decisions.
  /// @param data The encoded data, consisting of strategy address and calldata.
  

  /// @dev Re-invest whatever the worker is working on.
  

  /// @dev Return the amount of wei to get back if we are to liquidate the position.
  

  /// @dev Liquidate the given position to token. Send all token back to its Vault.
  

  /// @dev SetStretegy that be able to executed by the worker.
  

  /// @dev Set address that can be reinvest
  

  /// @dev LP token holds by worker
  

  /// @dev Return the trading path that worker is using for convert BTOKEN->...->FTOKEN
  

  /// @dev Return the inverse of the path that worker is using for convert BTOKEN->...->FTOKEN
  function getReversedPath() external override view returns (address[] memory) { 
    address tmp;
    address[] memory reversedPath = path;
    for (uint i = 0; i < reversedPath.length / 2; i++) {
      tmp = reversedPath[i];
      reversedPath[i] = reversedPath[reversedPath.length - i - 1];
      reversedPath[reversedPath.length - i - 1] = tmp;
    }
    return reversedPath;
  }

  /// @dev Return the trading path that the worker is using to convert reward token to beneficial vault token
  function getRewardPath() external override view returns (address[] memory) { return rewardPath; }
}
