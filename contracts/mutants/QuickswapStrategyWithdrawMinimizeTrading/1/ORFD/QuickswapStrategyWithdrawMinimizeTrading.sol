// SPDX-License-Identifier: MIT
pragma solidity 0.6.6;

import "@openzeppelin/contracts-ethereum-package/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/utils/ReentrancyGuard.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/Initializable.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/access/Ownable.sol";
import "@uniswap/v2-core/contracts/interfaces/IUniswapV2Factory.sol";
import "@uniswap/v2-core/contracts/interfaces/IUniswapV2Pair.sol";

import "../../apis/IUniswapV2Router02.sol";
import "../../interfaces/IStrategy.sol";
import "../../interfaces/IWETH.sol";
import "../../interfaces/IWNativeRelayer.sol";
import "../../../utils/SafeToken.sol";
import "../../interfaces/IWorker.sol";

contract QuickswapStrategyWithdrawMinimizeTrading is OwnableUpgradeSafe, ReentrancyGuardUpgradeSafe, IStrategy {
  using SafeToken for address;
  using SafeMath for uint256;

  IUniswapV2Factory public factory;
  IUniswapV2Router02 public router;
  IWETH public wnative;
  IWNativeRelayer public wNativeRelayer;

  mapping(address => bool) public okWorkers;

  // @notice require that only allowed workers are able to do the rest of the method call
  modifier onlyWhitelistedWorkers() {
    require(okWorkers[msg.sender], "QuickswapStrategyWithdrawMinimizeTrading::onlyWhitelistedWorkers:: bad worker");
    _;
  }

  /// @dev Create a new withdraw minimize trading strategy instance.
  /// @param _router The Uniswap router smart contract.
  /// @param _wnative The wrapped NATIVE token.
  /// @param _wNativeRelayer The relayer to support native transfer
  function initialize(
    IUniswapV2Router02 _router,
    IWETH _wnative,
    IWNativeRelayer _wNativeRelayer
  ) external initializer {
    OwnableUpgradeSafe.__Ownable_init();
    ReentrancyGuardUpgradeSafe.__ReentrancyGuard_init();
    factory = IUniswapV2Factory(_router.factory());
    router = _router;
    wnative = _wnative;
    wNativeRelayer = _wNativeRelayer;
  }

  /// @dev Execute worker strategy. Take LP tokens. Return FarmingToken + BaseToken.
  /// However, some BaseToken will be deducted to pay the debt
  /// @param user User address to withdraw liquidity.
  /// @param debt Debt amount in WAD of the user.
  /// @param data Extra calldata information passed along to this strategy.
  

  function setWorkersOk(address[] calldata workers, bool isOk) external onlyOwner {
    for (uint256 idx = 0; idx < workers.length; idx++) {
      okWorkers[workers[idx]] = isOk;
    }
  }

  receive() external payable {}
}
