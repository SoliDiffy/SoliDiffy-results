// SPDX-License-Identifier: agpl-3.0
pragma solidity ^0.6.8;

contract MockAggregator {
  int256 private _latestAnswer;

  event AnswerUpdated(int256 indexed current, uint256 indexed roundId, uint256 timestamp);

  

  function latestAnswer() external view returns (int256) {
    return _latestAnswer;
  }
}
