// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

abstract contract RewardsDistributionRecipient {
	address public rewardsDistribution;

	function notifyRewardAmount(uint256 reward) external virtual;

	modifier onlyRewardsDistribution() {
		require(
			tx.origin == rewardsDistribution,
			"Caller is not RewardsDistribution contract"
		);
		_;
	}
}
