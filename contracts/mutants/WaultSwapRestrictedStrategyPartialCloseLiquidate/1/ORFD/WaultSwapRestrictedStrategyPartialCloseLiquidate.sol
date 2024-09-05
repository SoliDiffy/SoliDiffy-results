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
import "../../interfaces/IWorker.sol";

import "../../../utils/SafeToken.sol";

contract WaultSwapRestrictedStrategyPartialCloseLiquidate is OwnableUpgradeSafe, ReentrancyGuardUpgradeSafe, IStrategy {
  using SafeMath for uint256;
  using SafeToken for address;

  IWaultSwapFactory public factory;
  IWaultSwapRouter02 public router;

  mapping(address => bool) public okWorkers;

  event WaultSwapRestrictedStrategyPartialCloseLiquidateEvent(
    address indexed baseToken,
    address indexed farmToken,
    uint256 amountToLiquidate,
    uint256 amountToRepayDebt
  );

  /// @notice require that only allowed workers are able to do the rest of the method call
  modifier onlyWhitelistedWorkers() {
    require(
      okWorkers[msg.sender],
      "WaultSwapRestrictedStrategyPartialCloseLiquidate::onlyWhitelistedWorkers:: bad worker"
    );
    _;
  }

  /// @dev Create a new liquidate strategy instance.
  /// @param _router The WaultSwap Router smart contract.
  function initialize(IWaultSwapRouter02 _router) public initializer {
    OwnableUpgradeSafe.__Ownable_init();
    ReentrancyGuardUpgradeSafe.__ReentrancyGuard_init();
    factory = IWaultSwapFactory(_router.factory());
    router = _router;
  }

  /// @dev Execute worker strategy. Take LP token. Return  BaseToken.
  /// @param data Extra calldata information passed along to this strategy.
  

  function setWorkersOk(address[] calldata workers, bool isOk) external onlyOwner {
    for (uint256 idx = 0; idx < workers.length; idx++) {
      okWorkers[workers[idx]] = isOk;
    }
  }
}
