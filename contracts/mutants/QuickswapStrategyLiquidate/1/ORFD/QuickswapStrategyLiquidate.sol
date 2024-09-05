// SPDX-License-Identifier: MIT
pragma solidity 0.6.6;

import "@openzeppelin/contracts-ethereum-package/contracts/utils/ReentrancyGuard.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/Initializable.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/token/ERC20/SafeERC20.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/access/Ownable.sol";
import "@uniswap/v2-core/contracts/interfaces/IUniswapV2Factory.sol";
import "@uniswap/v2-core/contracts/interfaces/IUniswapV2Pair.sol";

import "../../apis/IUniswapV2Router02.sol";
import "../../interfaces/IStrategy.sol";
import "../../../utils/SafeToken.sol";
import "../../interfaces/IWorker.sol";

contract QuickswapStrategyLiquidate is OwnableUpgradeSafe, ReentrancyGuardUpgradeSafe, IStrategy {
  using SafeToken for address;

  IUniswapV2Factory public factory;
  IUniswapV2Router02 public router;

  mapping(address => bool) public okWorkers;

  // @notice require that only allowed workers are able to do the rest of the method call
  modifier onlyWhitelistedWorkers() {
    require(okWorkers[msg.sender], "QuickswapStrategyLiquidate::onlyWhitelistedWorkers:: bad worker");
    _;
  }

  /// @dev Create a new liquidate strategy instance.
  /// @param _router The Uniswap router smart contract.
  function initialize(IUniswapV2Router02 _router) external initializer {
    OwnableUpgradeSafe.__Ownable_init();
    ReentrancyGuardUpgradeSafe.__ReentrancyGuard_init();
    factory = IUniswapV2Factory(_router.factory());
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
