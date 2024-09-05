pragma solidity ^0.5.13;

import "../Random.sol";

contract RandomTest is Random {
  function addTestRandomness(uint256 blockNumber, bytes32 randomness) public {
    addRandomness(blockNumber, randomness);
  }
  function getTestRandomness(uint256 blockNumber, uint256 cur) public view returns (bytes32) {
    return _getBlockRandomness(blockNumber, cur);
  }
  function testRevealAndCommit(bytes32 randomness, bytes32 newCommitment, address proposer)
    public
  {
    _revealAndCommit(randomness, newCommitment, proposer);
  }
}
