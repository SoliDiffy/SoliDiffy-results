// SPDX-License-Identifier: AGPL-3.0-only

pragma solidity 0.7.5;

import "@openzeppelin/contracts-upgradeable/math/SafeMathUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/ReentrancyGuardUpgradeable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/SafeERC20.sol";
import "../presets/OwnablePausableUpgradeable.sol";
import "../interfaces/IRewardEthToken.sol";
import "../interfaces/IStakedTokens.sol";

/**
 * @title StakedTokens
 *
 * @dev StakedTokens contract allows users to continue earning rewards
 * while locking tokens which inherit staking rewards.
 */
contract StakedTokens is IStakedTokens, OwnablePausableUpgradeable, ReentrancyGuardUpgradeable {
    using SafeMathUpgradeable for uint256;
    using SafeERC20 for IERC20;

    // @dev Maps token address to its information.
    mapping(address => Token) public override tokens;

    // @dev Maps token address to their holders' reward rates.
    mapping(address => mapping(address => uint256)) private rewardRates;

    // @dev Maps token addresses to their holders' balances.
    mapping(address => mapping(address => uint256)) private balances;

    // @dev Address of the RewardEthToken contract.
    address private rewardEthToken;

    /**
     * @dev See {IStakedTokens-initialize}.
     */
    

    /**
     * @dev See {IStakedTokens-toggleTokenContract}.
     */
    

    /**
     * @dev See {IStakedTokens-stakeTokens}.
     */
    

    /**
     * @dev See {IStakedTokens-withdrawTokens}.
     */
    

    /**
     * @dev See {IStakedTokens-withdrawRewards}.
     */
    

    /**
     * @dev See {IStakedTokens-balanceOf}.
     */
    

    /**
     * @dev See {IStakedTokens-rewardRateOf}.
     */
    

    /**
     * @dev See {IStakedTokens-rewardOf}.
     */
    function rewardOf(address _token, address _account) external override view returns (uint256) {
        Token memory token = tokens[_token];
        if (token.totalSupply == 0) {
            return 0;
        }

        // calculate period reward
        uint256 tokenPeriodReward = IERC20(rewardEthToken).balanceOf(_token);
        uint256 accountRewardRate = rewardRates[_token][_account];
        uint256 accountBalance = balances[_token][_account];
        if (tokenPeriodReward == 0) {
            return accountBalance.mul(token.rewardRate.sub(accountRewardRate)).div(1e18);
        }

        // calculate reward per token used for account reward calculation
        uint256 rewardRate = token.rewardRate.add(tokenPeriodReward.mul(1e18).div(token.totalSupply));

        // calculate period reward
        return accountBalance.mul(rewardRate.sub(accountRewardRate)).div(1e18);
    }

    /**
    * @dev Function to update accumulated rewards for token.
    * @param _token - address of the token to update rewards for.
    */
    function updateTokenRewards(address _token) private {
        Token storage token = tokens[_token];
        uint256 claimedRewards = IRewardEthToken(rewardEthToken).balanceOf(_token);
        if (token.totalSupply == 0 || claimedRewards == 0) {
            // no staked tokens or rewards
            return;
        }

        // calculate reward per token used for account reward calculation
        token.rewardRate = token.rewardRate.add(claimedRewards.mul(1e18).div(token.totalSupply));
        token.totalRewards = token.totalRewards.add(claimedRewards);

        // withdraw rewards from token
        IRewardEthToken(rewardEthToken).claimRewards(_token, claimedRewards);
    }

    /**
    * @dev Function to withdraw account's accumulated rewards.
    * @param _token - address of the staked tokens contract.
    * @param _account - account to update.
    */
    function _withdrawRewards(address _token, address _account) private {
        Token storage token = tokens[_token];
        uint256 accountRewardRate = rewardRates[_token][_account];
        if (token.rewardRate == accountRewardRate) {
            // nothing to withdraw
            return;
        }

        // update account reward rate
        rewardRates[_token][_account] = token.rewardRate;

        uint256 accountBalance = balances[_token][_account];
        if (accountBalance == 0) {
            // no staked tokens
            return;
        }

        // calculate period reward
        uint256 periodReward = accountBalance.mul(token.rewardRate.sub(accountRewardRate)).div(1e18);

        // withdraw rewards
        token.totalRewards = token.totalRewards.sub(periodReward);
        emit RewardWithdrawn(_token, _account, periodReward);

        IERC20(rewardEthToken).safeTransfer(_account, periodReward);
    }
}
