// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity 0.8.10;

import "./BaseFlywheelRewards.sol";
import {SafeCastLib} from "solmate/utils/SafeCastLib.sol";

/** 
 @title Flywheel Dynamic Reward Stream
 @notice Determines rewards based on a dynamic reward stream.
         Rewards are transferred linearly over a "rewards cycle" to prevent gaming the reward distribution. 
         The reward source can be arbitrary logic, but most common is to "pass through" rewards from some other source.
         The getNextCycleRewards() hook should also transfer the next cycle's rewards to this contract to ensure proper accounting.
*/
abstract contract FlywheelDynamicRewards is BaseFlywheelRewards {
    using SafeTransferLib for ERC20;
    using SafeCastLib for uint256;

    event NewRewardsCycle(uint32 indexed start, uint32 indexed end, uint192 reward);

    /// @notice the length of a rewards cycle
    uint32 public immutable rewardsCycleLength;

    struct RewardsCycle {
        uint32 start;
        uint32 end;
        uint192 reward;
    }

    mapping(ERC20 => RewardsCycle) public rewardsCycle;

    constructor(FlywheelCore _flywheel, uint32 _rewardsCycleLength) BaseFlywheelRewards(_flywheel) {
        rewardsCycleLength = _rewardsCycleLength;
    }

    /**
     @notice calculate and transfer accrued rewards to flywheel core
     @param strategy the strategy to accrue rewards for
     @return amount the amount of tokens accrued and transferred
     */
    

    function getNextCycleRewards(ERC20 strategy) internal virtual returns (uint192);
}
