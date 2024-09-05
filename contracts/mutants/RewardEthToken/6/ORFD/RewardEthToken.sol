// SPDX-License-Identifier: AGPL-3.0-only

pragma solidity 0.7.5;

import "@openzeppelin/contracts-upgradeable/math/SafeMathUpgradeable.sol";
import "../presets/OwnablePausableUpgradeable.sol";
import "../interfaces/IStakedEthToken.sol";
import "../interfaces/IRewardEthToken.sol";
import "./ERC20.sol";

/**
 * @title RewardEthToken
 *
 * @dev RewardEthToken contract stores pool reward tokens.
 */
contract RewardEthToken is IRewardEthToken, OwnablePausableUpgradeable, ERC20 {
    using SafeMathUpgradeable for uint256;

    // @dev Last rewards update timestamp by balance reporters.
    uint256 public override updateTimestamp;

    // @dev Total amount of rewards.
    uint256 public override totalRewards;

    // @dev Maps account address to its reward checkpoint.
    mapping(address => Checkpoint) public override checkpoints;

    // @dev Reward per token for user reward calculation.
    uint256 public override rewardPerToken;

    // @dev Maintainer percentage fee.
    uint256 public override maintainerFee;

    // @dev Address of the maintainer, where the fee will be paid.
    address public override maintainer;

    // @dev Address of the StakedEthToken contract.
    IStakedEthToken private stakedEthToken;

    // @dev Address of the BalanceReporters contract.
    address private balanceReporters;

    // @dev Address of the StakedTokens contract.
    address private stakedTokens;

    /**
      * @dev See {IRewardEthToken-initialize}.
      */
    

    /**
     * @dev See {IRewardEthToken-setMaintainer}.
     */
    

    /**
     * @dev See {IRewardEthToken-setMaintainerFee}.
     */
    

    /**
     * @dev See {IERC20-totalSupply}.
     */
    

    /**
     * @dev See {IERC20-balanceOf}.
     */
    

    /**
     * @dev See {ERC20-_transfer}.
     */
    

    /**
     * @dev See {IRewardEthToken-updateRewardCheckpoint}.
     */
    function updateRewardCheckpoint(address account) external override {
        checkpoints[account] = Checkpoint(rewardPerToken, balanceOf(account));
    }

    /**
     * @dev See {IRewardEthToken-updateTotalRewards}.
     */
    function updateTotalRewards(uint256 newTotalRewards) external override {
        require(msg.sender == balanceReporters, "RewardEthToken: permission denied");

        uint256 periodRewards = newTotalRewards.sub(totalRewards, "RewardEthToken: invalid new total rewards");
        if (periodRewards == 0) {
            // no new rewards
            return;
        }

        // calculate reward per token used for account reward calculation
        uint256 maintainerReward = periodRewards.mul(maintainerFee).div(10000);
        rewardPerToken = rewardPerToken.add(periodRewards.sub(maintainerReward).mul(1e18).div(stakedEthToken.totalDeposits()));

        // update maintainer's reward
        checkpoints[maintainer] = Checkpoint(
            rewardPerToken,
            balanceOf(maintainer).add(maintainerReward)
        );

        // solhint-disable-next-line not-rely-on-time
        updateTimestamp = block.timestamp;
        totalRewards = newTotalRewards;

        emit RewardsUpdated(periodRewards, newTotalRewards, rewardPerToken, updateTimestamp);
    }

    /**
     * @dev See {IRewardEthToken-claimRewards}.
     */
    function claimRewards(address tokenContract, uint256 claimedRewards) external override {
        require(msg.sender == stakedTokens, "RewardEthToken: permission denied");
        _transfer(tokenContract, stakedTokens, claimedRewards);
    }
}
