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
import "@openzeppelin/contracts-ethereum-package/contracts/access/Ownable.sol";

import "../../apis/mdex/IMdexFactory.sol";
import "../../apis/mdex/IMdexRouter.sol";
import "@pancakeswap-libs/pancake-swap-core/contracts/interfaces/IPancakePair.sol";
import "../../interfaces/IMdexSwapMining.sol";

import "../../interfaces/IStrategy.sol";
import "../../interfaces/IVault.sol";
import "../../interfaces/IWorker.sol";

import "../../../utils/SafeToken.sol";
import "../../../utils/AlpacaMath.sol";

contract MdexRestrictedStrategyAddTwoSidesOptimal is OwnableUpgradeSafe, ReentrancyGuardUpgradeSafe, IStrategy {
  using SafeToken for address;
  using SafeMath for uint256;

  /// @notice Events
  event SetWorkerOk(address indexed caller, address worker, bool isOk);
  event WithdrawTradingRewards(address indexed caller, address to, uint256 amount);

  IMdexFactory public factory;
  IMdexRouter public router;
  address public mdx;
  IVault public vault;

  mapping(address => bool) public okWorkers;

  /// @notice require that only allowed workers are able to do the rest of the method call
  modifier onlyWhitelistedWorkers() {
    require(okWorkers[msg.sender], "MdexRestrictedStrategyAddTwoSidesOptimal::onlyWhitelistedWorkers:: bad worker");
    _;
  }

  /// @dev Create a new add two-side optimal strategy instance.
  /// @param _router The Mdex Router smart contract.
  /// @param _vault The vault contract to request fund.
  /// @param _mdx The address of mdex token.
  function initialize(
    IMdexRouter _router,
    IVault _vault,
    address _mdx
  ) external initializer {
    OwnableUpgradeSafe.__Ownable_init();
    ReentrancyGuardUpgradeSafe.__ReentrancyGuard_init();
    factory = IMdexFactory(_router.factory());
    router = _router;
    vault = _vault;
    mdx = _mdx;
  }

  /// @dev Compute optimal deposit amount
  /// @param amtA amount of token A desired to deposit
  /// @param amtB amonut of token B desired to deposit
  /// @param resA amount of token A in reserve
  /// @param resB amount of token B in reserve
  function optimalDeposit(
    uint256 amtA,
    uint256 amtB,
    uint256 resA,
    uint256 resB,
    uint256 fee
  ) internal pure returns (uint256 swapAmt, bool isReversed) {
    if (amtA.mul(resB) >= amtB.mul(resA)) {
      swapAmt = _optimalDepositA(amtA, amtB, resA, resB, fee);
      isReversed = false;
    } else {
      swapAmt = _optimalDepositA(amtB, amtA, resB, resA, fee);
      isReversed = true;
    }
  }

  /// @dev Compute optimal deposit amount helper
  /// @param amtA amount of token A desired to deposit
  /// @param amtB amonut of token B desired to deposit
  /// @param resA amount of token A in reserve
  /// @param resB amount of token B in reserve
  function _optimalDepositA(
    uint256 amtA,
    uint256 amtB,
    uint256 resA,
    uint256 resB,
    uint256 fee
  ) internal pure returns (uint256) {
    require(amtA.mul(resB) >= amtB.mul(resA), "Reversed");

    uint256 a = uint256(10000).sub(fee);
    uint256 b = uint256(20000).sub(fee).mul(resA);
    uint256 _c = (amtA.mul(resB)).sub(amtB.mul(resA));
    uint256 c = _c.mul(10000).div(amtB.add(resB)).mul(resA);

    uint256 d = a.mul(c).mul(4);
    uint256 e = AlpacaMath.sqrt(b.mul(b).add(d));

    uint256 numerator = e.sub(b);
    uint256 denominator = a.mul(2);

    return numerator.div(denominator);
  }

  /// @dev Execute worker strategy. Take BaseToken + FarmingToken. Return LP tokens.
  /// @param data Extra calldata information passed along to this strategy.
  

  function setWorkersOk(address[] calldata workers, bool isOk) external onlyOwner {
    for (uint256 idx = 0; idx < workers.length; idx++) {
      okWorkers[workers[idx]] = isOk;
      emit SetWorkerOk(msg.sender, workers[idx], isOk);
    }
  }

  /// @dev Withdraw trading all reward.
  /// @param to The address to transfer trading reward to.
  function withdrawTradingRewards(address to) external onlyOwner {
    uint256 mdxBalanceBefore = mdx.myBalance();
    IMdexSwapMining(router.swapMining()).takerWithdraw();
    uint256 mdxBalanceAfter = mdx.myBalance().sub(mdxBalanceBefore);
    mdx.safeTransfer(to, mdxBalanceAfter);
    emit WithdrawTradingRewards(msg.sender, to, mdxBalanceAfter);
  }

  /// @dev Get trading rewards by pIds.
  /// @param pIds pool ids to retrieve reward amount.
  function getMiningRewards(uint256[] calldata pIds) external view returns (uint256) {
    address swapMiningAddress = router.swapMining();
    uint256 totalReward;
    for (uint256 index = 0; index < pIds.length; index++) {
      (uint256 reward, ) = IMdexSwapMining(swapMiningAddress).getUserReward(pIds[index]);
      totalReward = totalReward.add(reward);
    }
    return totalReward;
  }
}
