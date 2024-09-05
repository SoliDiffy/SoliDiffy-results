// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity 0.8.10;

import {ERC20} from "solmate/tokens/ERC20.sol";

contract MockRewardsStream {
    ERC20 public rewardToken;
    uint256 rewardAmount;

    constructor(ERC20 token, uint256 amount) {
        rewardAmount = amount;
        rewardToken = token;
    }

    function setRewardAmount(uint256 newAmount) public {
        rewardAmount = newAmount;
    }

    function getRewards() public returns (uint256 amount) {
        amount = rewardAmount;
        rewardToken.transfer(msg.sender, amount);
    }
}
