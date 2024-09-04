// SPDX-License-Identifier: AGPL-3.0-only

pragma solidity 0.7.5;

import "@openzeppelin/contracts-upgradeable/math/SafeMathUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/ReentrancyGuardUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/CountersUpgradeable.sol";
import "@uniswap/v2-core/contracts/interfaces/IUniswapV2Pair.sol";
import "./presets/OwnablePausableUpgradeable.sol";
import "./interfaces/IRewardEthToken.sol";
import "./interfaces/IBalanceReporters.sol";

/**
 * @title BalanceReporters
 *
 * @dev Balance reporters contract stores accounts responsible for submitting pool total rewards to RewardEthToken contract.
 * Rewards are updated only when a threshold of inputs from different reporters received.
 */
contract BalanceReporters is IBalanceReporters, ReentrancyGuardUpgradeable, OwnablePausableUpgradeable {
    using SafeMathUpgradeable for uint256;
    using CountersUpgradeable for CountersUpgradeable.Counter;

    bytes32 public constant REPORTER_ROLE = keccak256("REPORTER_ROLE");

    // @dev Maps candidate ID to the number of votes it has.
    mapping(bytes32 => uint256) public override candidates;

    // @dev List of supported rwETH Uniswap pairs.
    address[] private rewardEthUniswapPairs;

    // @dev Maps vote ID to whether it was submitted or not.
    mapping(bytes32 => bool) private submittedVotes;

    // @dev Address of the RewardEthToken contract.
    IRewardEthToken private rewardEthToken;

    // @dev Nonce for RewardEthToken total rewards.
    CountersUpgradeable.Counter private totalRewardsNonce;

    /**
    * @dev Modifier for checking whether the caller is a reporter.
    */
    modifier onlyReporter() {
        require(hasRole(REPORTER_ROLE, msg.sender), "BalanceReporters: permission denied");
        _;
    }

    /**
     * @dev See {IBalanceReporters-initialize}.
     */
    

    /**
     * @dev See {IBalanceReporters-getRewardEthUniswapPairs}.
     */
    

    /**
     * @dev See {IBalanceReporters-hasTotalRewardsVote}.
     */
    

    /**
     * @dev See {IBalanceReporters-isReporter}.
     */
    

    /**
     * @dev See {IBalanceReporters-addReporter}.
     */
    

    /**
     * @dev See {IBalanceReporters-removeReporter}.
     */
    

    /**
     * @dev See {IBalanceReporters-setRewardEthUniswapPairs}.
     */
    

    /**
     * @dev See {IBalanceReporters-voteForTotalRewards}.
     */
    
}
