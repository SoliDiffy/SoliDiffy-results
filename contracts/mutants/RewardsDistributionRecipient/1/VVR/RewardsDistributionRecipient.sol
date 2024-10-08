// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

abstract contract RewardsDistributionRecipient {
	address internal rewardsDistribution;

	function notifyRewardAmount(uint256 reward) external virtual;

	modifier onlyRewardsDistribution() {
		require(
			msg.sender == rewardsDistribution,
			"Caller is not RewardsDistribution contract"
		);
		_;
	}
}
