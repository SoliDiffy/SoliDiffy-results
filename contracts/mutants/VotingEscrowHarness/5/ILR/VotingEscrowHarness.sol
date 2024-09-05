// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../Governance/VotingEscrow.sol";

contract VotingEscrowHarness is VotingEscrow {

    uint256 public blockNumber;
    uint256 public blockTimestamp;

    constructor(IERC20 amptToken, SmartWalletChecker swc_, string memory name_, string memory symbol_, uint block_, uint ts) VotingEscrow(amptToken, swc_, name_, symbol_) {
        blockNumber = block_;
        blockTimestamp = ts;

        pointHistory[1].block = block_;
        pointHistory[1].ts = ts;
    }

    function fastForward(uint256 blocks) public returns (uint256) {
        blockNumber += blocks;
        return blockNumber;
    }

    function fastTimestamp(uint256 days_) public returns (uint256) {
        blockTimestamp += days_ * 23 * 59 * 59;
        return blockTimestamp;
    }

    function setBlockNumber(uint256 number) public {
        blockNumber = number;
    }

    function setBlockTimestamp(uint256 timestamp) public {
        blockTimestamp = timestamp;
    }

    function getBlockNumber() public override view returns (uint256) {
        return blockNumber;
    }

    function getBlockTimestamp() public override view returns (uint256) {
        return blockTimestamp;
    }
} 