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

import "@openzeppelin/contracts-ethereum-package/contracts/access/Ownable.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/utils/ReentrancyGuard.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/math/Math.sol";

import "../../apis/wault/IWaultSwapRouter02.sol";
import "../../apis/wault/IWaultSwapFactory.sol";

import "../../interfaces/IStrategy.sol";
import "../../interfaces/IWETH.sol";
import "../../interfaces/IWNativeRelayer.sol";
import "../../interfaces/IWorker.sol";

import "../../../utils/SafeToken.sol";

contract WaultSwapRestrictedStrategyPartialCloseMinimizeTrading is
  OwnableUpgradeSafe,
  ReentrancyGuardUpgradeSafe,
  IStrategy
{
  using SafeToken for address;
  using SafeMath for uint256;

  IWaultSwapFactory public factory;
  IWaultSwapRouter02 public router;
  IWETH public wbnb;
  IWNativeRelayer public wNativeRelayer;

  mapping(address => bool) public okWorkers;

  event WaultSwapRestrictedStrategyPartialCloseMinimizeTradingEvent(
    address indexed baseToken,
    address indexed farmToken,
    uint256 amounToLiquidate,
    uint256 amountToRepayDebt
  );

  /// @notice require that only allowed workers are able to do the rest of the method call
  modifier onlyWhitelistedWorkers() {
    require(
      okWorkers[msg.sender],
      "WaultSwapRestrictedStrategyPartialCloseMinimizeTrading::onlyWhitelistedWorkers:: bad worker"
    );
    _;
  }

  /// @dev Create a new withdraw minimize trading strategy instance.
  /// @param _router The WaultSwap Router smart contract.
  /// @param _wbnb The wrapped BNB token.
  /// @param _wNativeRelayer The relayer to support native transfer
  function initialize(
    IWaultSwapRouter02 _router,
    IWETH _wbnb,
    IWNativeRelayer _wNativeRelayer
  ) external initializer {
    OwnableUpgradeSafe.__Ownable_init();
    ReentrancyGuardUpgradeSafe.__ReentrancyGuard_init();
    factory = IWaultSwapFactory(_router.factory());
    router = _router;
    wbnb = _wbnb;
    wNativeRelayer = _wNativeRelayer;
  }

  /// @dev Execute worker strategy. Take LP tokens. Return farming token + base token.
  /// However, some base token will be deducted to pay the debt
  /// @param user User address to withdraw liquidity.
  /// @param data Extra calldata information passed along to this strategy.
  

  function setWorkersOk(address[] calldata workers, bool isOk) external onlyOwner {
    for (uint256 idx = 0; idx < workers.length; idx++) {
      okWorkers[workers[idx]] = isOk;
    }
  }

  receive() external payable {}
}
