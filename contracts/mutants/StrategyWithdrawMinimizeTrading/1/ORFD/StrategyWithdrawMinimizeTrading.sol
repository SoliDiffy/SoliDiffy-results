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
import "../../interfaces/IWETH.sol";
import "../../interfaces/IWNativeRelayer.sol";
import "../../../utils/SafeToken.sol";

contract StrategyWithdrawMinimizeTrading is ReentrancyGuardUpgradeSafe, IStrategy {
  using SafeToken for address;
  using SafeMath for uint256;

  IPancakeFactory public factory;
  IPancakeRouter02 public router;
  IWETH public wbnb;
  IWNativeRelayer public wNativeRelayer;

  /// @dev Create a new withdraw minimize trading strategy instance.
  /// @param _router The PancakeSwap Router smart contract.
  /// @param _wbnb The wrapped BNB token.
  /// @param _wNativeRelayer The relayer to support native transfer
  function initialize(
    IPancakeRouter02 _router,
    IWETH _wbnb,
    IWNativeRelayer _wNativeRelayer
  ) external initializer {
    ReentrancyGuardUpgradeSafe.__ReentrancyGuard_init();

    factory = IPancakeFactory(_router.factory());
    router = _router;
    wbnb = _wbnb;
    wNativeRelayer = _wNativeRelayer;
  }

  /// @dev Execute worker strategy. Take LP tokens. Return FarmingToken + BaseToken.
  /// However, some BaseToken will be deducted to pay the debt
  /// @param user User address to withdraw liquidity.
  /// @param debt Debt amount in WAD of the user.
  /// @param data Extra calldata information passed along to this strategy.
  

  receive() external payable {}
}
