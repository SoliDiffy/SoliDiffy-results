// SPDX-License-Identifier: MIT
pragma solidity ^0.6.7;

import "./strategy-base.sol";

abstract contract StrategyBasisFarmBase is StrategyBase {
    // <token1>/<token2> pair
    address public token1;
    address public token2;
    address public rewards;
    address public pool;
    address[] public path;
   

    // How much rewards tokens to keep?
    uint256 public keepRewards = 0;
    uint256 public constant keepRewardsMax = 10000;

    uint256 public poolId;

    constructor(
        address _rewards,
        address _pool,
        address _controller,
        address _token1,
        address _token2,
        address[] memory _path,
        address _lp,
        address _strategist,
        uint256 _poolId
    )
        public
        StrategyBase(_lp, _strategist, _controller)
    {
        token1 = _token1;
        token2 = _token2;
        rewards = _rewards;
        path = _path;
        pool = _pool;
        poolId = _poolId;
    }

    // **** Setters ****

    function setKeep(uint256 _keep) external {
        require(msg.sender == strategist, "!strategist");
        keepRewards = _keep;
    }

    // **** State Mutations ****
    

    function getHarvestable() external view returns (uint256) {
        return IStakingRewards(pool).rewardEarned(poolId,address(this));
    }

    

    

    // SWC-104-Unchecked Call Return Value: L78 - L152
    
}
