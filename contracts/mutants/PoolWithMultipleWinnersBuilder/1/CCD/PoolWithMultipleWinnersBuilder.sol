// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.6.0 <0.7.0;
pragma experimental ABIEncoderV2;

import "@openzeppelin/contracts-upgradeable/utils/SafeCastUpgradeable.sol";

import "../registry/RegistryInterface.sol";
import "../prize-pool/compound/CompoundPrizePoolProxyFactory.sol";
import "../prize-pool/stake/StakePrizePoolProxyFactory.sol";
import "./MultipleWinnersBuilder.sol";

contract PoolWithMultipleWinnersBuilder {
  using SafeCastUpgradeable for uint256;

  event CompoundPrizePoolWithMultipleWinnersCreated(address indexed prizePool, address indexed prizeStrategy);
  event StakePrizePoolWithMultipleWinnersCreated(address indexed prizePool, address indexed prizeStrategy);

  /// @notice The configuration used to initialize the Compound Prize Pool
  struct CompoundPrizePoolConfig {
    CTokenInterface cToken;
    uint256 maxExitFeeMantissa;
    uint256 maxTimelockDuration;
  }

  struct StakePrizePoolConfig {
    IERC20Upgradeable token;
    uint256 maxExitFeeMantissa;
    uint256 maxTimelockDuration;
  }

  RegistryInterface public reserveRegistry;
  CompoundPrizePoolProxyFactory public compoundPrizePoolProxyFactory;
  StakePrizePoolProxyFactory public stakePrizePoolProxyFactory;
  MultipleWinnersBuilder public multipleWinnersBuilder;

  

  function createCompoundMultipleWinners(
    CompoundPrizePoolConfig memory prizePoolConfig,
    MultipleWinnersBuilder.MultipleWinnersConfig memory prizeStrategyConfig,
    uint8 decimals
  ) external returns (CompoundPrizePool) {
    CompoundPrizePool prizePool = compoundPrizePoolProxyFactory.create();
    MultipleWinners prizeStrategy = multipleWinnersBuilder.createMultipleWinners(
      prizePool,
      prizeStrategyConfig,
      decimals,
      msg.sender
    );
    prizePool.initialize(
      reserveRegistry,
      _tokens(prizeStrategy),
      prizePoolConfig.maxExitFeeMantissa,
      prizePoolConfig.maxTimelockDuration,
      CTokenInterface(prizePoolConfig.cToken)
    );
    prizePool.setPrizeStrategy(prizeStrategy);
    prizePool.setCreditPlanOf(
      address(prizeStrategy.ticket()),
      prizeStrategyConfig.ticketCreditRateMantissa.toUint128(),
      prizeStrategyConfig.ticketCreditLimitMantissa.toUint128()
    );
    prizePool.transferOwnership(msg.sender);
    emit CompoundPrizePoolWithMultipleWinnersCreated(address(prizePool), address(prizeStrategy));
    return prizePool;
  }

  function createStakeMultipleWinners(
    StakePrizePoolConfig memory prizePoolConfig,
    MultipleWinnersBuilder.MultipleWinnersConfig memory prizeStrategyConfig,
    uint8 decimals
  ) external returns (StakePrizePool) {
    StakePrizePool prizePool = stakePrizePoolProxyFactory.create();
    MultipleWinners prizeStrategy = multipleWinnersBuilder.createMultipleWinners(
      prizePool,
      prizeStrategyConfig,
      decimals,
      msg.sender
    );
    prizePool.initialize(
      reserveRegistry,
      _tokens(prizeStrategy),
      prizePoolConfig.maxExitFeeMantissa,
      prizePoolConfig.maxTimelockDuration,
      prizePoolConfig.token
    );
    prizePool.setPrizeStrategy(prizeStrategy);
    prizePool.setCreditPlanOf(
      address(prizeStrategy.ticket()),
      prizeStrategyConfig.ticketCreditRateMantissa.toUint128(),
      prizeStrategyConfig.ticketCreditLimitMantissa.toUint128()
    );
    prizePool.transferOwnership(msg.sender);
    emit StakePrizePoolWithMultipleWinnersCreated(address(prizePool), address(prizeStrategy));
    return prizePool;
  }

  function _tokens(MultipleWinners _multipleWinners) internal returns (ControlledTokenInterface[] memory) {
    ControlledTokenInterface[] memory tokens = new ControlledTokenInterface[](2);
    tokens[0] = ControlledTokenInterface(address(_multipleWinners.ticket()));
    tokens[1] = ControlledTokenInterface(address(_multipleWinners.sponsorship()));
    return tokens;
  }

}
