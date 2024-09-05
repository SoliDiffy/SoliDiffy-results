// SPDX-License-Identifier: AGPL-3.0-only

pragma solidity 0.7.5;

import "@openzeppelin/contracts-upgradeable/math/SafeMathUpgradeable.sol";
import "../presets/OwnablePausableUpgradeable.sol";
import "../interfaces/IStakedEthToken.sol";
import "../interfaces/IRewardEthToken.sol";
import "./ERC20.sol";

/**
 * @title StakedEthToken
 *
 * @dev StakedEthToken contract stores pool staked tokens.
 */
contract StakedEthToken is IStakedEthToken, OwnablePausableUpgradeable, ERC20 {
    using SafeMathUpgradeable for uint256;

    // @dev Total amount of deposits.
    uint256 public override totalDeposits;

    // @dev Maps account address to its deposit amount.
    mapping(address => uint256) private deposits;

    // @dev Address of the Pool contract.
    address private pool;

    // @dev Address of the RewardEthToken contract.
    IRewardEthToken private rewardEthToken;

    /**
     * @dev See {StakedEthToken-initialize}.
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
     * @dev See {IStakedEthToken-mint}.
     */
    function mint(address account, uint256 amount) external override {
        require(msg.sender == pool, "StakedEthToken: permission denied");

        // start calculating account rewards with updated deposit amount
        rewardEthToken.updateRewardCheckpoint(account);
        totalDeposits = totalDeposits.add(amount);
        deposits[account] = deposits[account].add(amount);

        emit Transfer(address(0), account, amount);
    }
}
