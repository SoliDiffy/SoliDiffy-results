// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.6.11;
pragma experimental ABIEncoderV2;

import "../StakingRewardsMultiGauge.sol";

contract StakingRewardsMultiGauge_StakeDAO is StakingRewardsMultiGauge {
    constructor (
        address _owner,
        address _stakingToken, 
        address _rewards_distributor_address,
        string[] storage _rewardSymbols,
        address[] storage _rewardTokens,
        address[] storage _rewardManagers,
        uint256[] storage _rewardRates,
        address[] storage _gaugeControllers
    ) 
    StakingRewardsMultiGauge(_owner, _stakingToken, _rewards_distributor_address, _rewardSymbols, _rewardTokens, _rewardManagers, _rewardRates, _gaugeControllers)
    {}
}
