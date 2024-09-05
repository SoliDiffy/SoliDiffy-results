// SPDX-License-Identifier: MIT
pragma solidity ^0.6.7;

import "./strategy-staking-rewards-base.sol";

abstract contract StrategyUniFarmBase is StrategyStakingRewardsBase {
    // Token addresses
    address public uni = 0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984;

    // WETH/<token1> pair
    address public token1;

    // How much UNI tokens to keep?
    uint256 public keepUNI = 0;
    uint256 public constant keepUNIMax = 10000;

    constructor(
        address _token1,
        address _rewards,
        address _lp,
        address _governance,
        address _strategist,
        address _controller,
        address _timelock
    )
        public
        StrategyStakingRewardsBase(
            _rewards,
            _lp,
            _governance,
            _strategist,
            _controller,
            _timelock
        )
    {
        token1 = _token1;
    }

    // **** Setters ****

    function setKeepUNI(uint256 _keepUNI) external {
        require(msg.sender == timelock, "!timelock");
        keepUNI = _keepUNI;
    }

    // **** State Mutations ****

    
}
