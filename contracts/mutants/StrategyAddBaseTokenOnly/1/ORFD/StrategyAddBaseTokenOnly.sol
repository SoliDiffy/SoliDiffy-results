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

import "@openzeppelin/contracts-ethereum-package/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/utils/ReentrancyGuard.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/Initializable.sol";

import "@pancakeswap-libs/pancake-swap-core/contracts/interfaces/IPancakeFactory.sol";
import "@pancakeswap-libs/pancake-swap-core/contracts/interfaces/IPancakePair.sol";

import "../../apis/pancake/IPancakeRouter02.sol";
import "../../interfaces/IStrategy.sol";
import "../../../utils/SafeToken.sol";
import "../../../utils/AlpacaMath.sol";

contract StrategyAddBaseTokenOnly is ReentrancyGuardUpgradeSafe, IStrategy {
  using SafeToken for address;
  using SafeMath for uint256;

  IPancakeFactory public factory;
  IPancakeRouter02 public router;

  /// @dev Create a new add Token only strategy instance.
  /// @param _router The PancakeSwap Router smart contract.
  function initialize(IPancakeRouter02 _router) external initializer {
    ReentrancyGuardUpgradeSafe.__ReentrancyGuard_init();

    factory = IPancakeFactory(_router.factory());
    router = _router;
  }

  /// @dev Execute worker strategy. Take BaseToken. Return LP tokens.
  /// @param data Extra calldata information passed along to this strategy.
  
}
