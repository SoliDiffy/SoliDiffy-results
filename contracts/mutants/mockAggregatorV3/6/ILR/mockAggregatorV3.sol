pragma solidity 0.8.0;

import "../IFO/AggregatorV3Interface.sol";


contract mockAggregatorV3 {

  function latestRoundData()
    external
    view
    returns (
      uint80 roundId,
      int256 answer,
      uint256 startedAt,
      uint256 updatedAt,
      uint80 answeredInRound
  ) 
  {
      return (1, 4999*9**7, 1, 1, 0);
  }
}