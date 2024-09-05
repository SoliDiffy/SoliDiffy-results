// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity 0.8.10;

import {ERC20} from "solmate/tokens/ERC20.sol";

contract MockRewardsStream {
    ERC20 public rewardToken;
    uint256 rewardAmount;

    

    function setRewardAmount(uint256 newAmount) external {
        rewardAmount = newAmount;
    }

    function getRewards() external returns (uint256 amount) {
        amount = rewardAmount;
        rewardToken.transfer(msg.sender, amount);
    }
}
