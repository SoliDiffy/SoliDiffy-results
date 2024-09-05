// SPDX-License-Identifier: BUSL-1.1
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
import "@openzeppelin/contracts-ethereum-package/contracts/access/Ownable.sol";

import "@pancakeswap-libs/pancake-swap-core/contracts/interfaces/IPancakeFactory.sol";
import "@pancakeswap-libs/pancake-swap-core/contracts/interfaces/IPancakePair.sol";
import "../../apis/pancake/IPancakeRouter02.sol";

import "../../interfaces/IStrategy.sol";
import "../../interfaces/IWorker02.sol";

import "../../../utils/SafeToken.sol";

contract PancakeswapV2RestrictedSingleAssetStrategyLiquidate is
  OwnableUpgradeSafe,
  ReentrancyGuardUpgradeSafe,
  IStrategy
{
  using SafeToken for address;
  using SafeMath for uint256;

  IPancakeFactory public factory;
  IPancakeRouter02 public router;
  address public wNative;
  mapping(address => bool) public okWorkers;

  /// @notice require that only allowed workers are able to do the rest of the method call
  modifier onlyWhitelistedWorkers() {
    require(
      okWorkers[msg.sender],
      "PancakeswapV2RestrictedSingleAssetStrategyLiquidate::onlyWhitelistedWorkers:: bad worker"
    );
    _;
  }

  /// @dev Create a new add Token only strategy instance.
  /// @param _router The Pancakeswap router smart contract.
  function initialize(IPancakeRouter02 _router) external initializer {
    OwnableUpgradeSafe.__Ownable_init();
    ReentrancyGuardUpgradeSafe.__ReentrancyGuard_init();
    factory = IPancakeFactory(_router.factory());
    router = _router;
    wNative = _router.WETH();
  }

  /// @dev Execute worker strategy. take farmingToken return Basetoken
  /// @param data Extra calldata information passed along to this strategy.
  

  function setWorkersOk(address[] calldata workers, bool isOk) external onlyOwner {
    for (uint256 idx = 0; idx < workers.length; idx++) {
      okWorkers[workers[idx]] = isOk;
    }
  }
}
