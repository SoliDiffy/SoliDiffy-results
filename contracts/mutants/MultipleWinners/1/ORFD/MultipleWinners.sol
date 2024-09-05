// SPDX-License-Identifier: MIT

pragma solidity ^0.6.12;

import "../PeriodicPrizeStrategy.sol";

contract MultipleWinners is PeriodicPrizeStrategy {

  uint256 internal __numberOfWinners;

  bool public splitExternalErc20Awards;

  event SplitExternalErc20AwardsSet(bool splitExternalErc20Awards);

  event NumberOfWinnersSet(uint256 numberOfWinners);

  event NoWinners();

  function initializeMultipleWinners (
    uint256 _prizePeriodStart,
    uint256 _prizePeriodSeconds,
    PrizePool _prizePool,
    TicketInterface _ticket,
    IERC20Upgradeable _sponsorship,
    RNGInterface _rng,
    uint256 _numberOfWinners
  ) public initializer {
    IERC20Upgradeable[] memory _externalErc20Awards;

    PeriodicPrizeStrategy.initialize(
      _prizePeriodStart,
      _prizePeriodSeconds,
      _prizePool,
      _ticket,
      _sponsorship,
      _rng,
      _externalErc20Awards
    );

    _setNumberOfWinners(_numberOfWinners);
  }

  function setSplitExternalErc20Awards(bool _splitExternalErc20Awards) external onlyOwner requireAwardNotInProgress {
    splitExternalErc20Awards = _splitExternalErc20Awards;

    emit SplitExternalErc20AwardsSet(splitExternalErc20Awards);
  }

  function setNumberOfWinners(uint256 count) external onlyOwner requireAwardNotInProgress {
    _setNumberOfWinners(count);
  }

  function _setNumberOfWinners(uint256 count) internal {
    require(count > 0, "MultipleWinners/winners-gte-one");

    __numberOfWinners = count;
    emit NumberOfWinnersSet(count);
  }

  function numberOfWinners() external view returns (uint256) {
    return __numberOfWinners;
  }

  
}
