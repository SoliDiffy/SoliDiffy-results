// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

import "./PowerBombAvaxCurve.sol";

contract PowerBombAvaxCurve33 is PowerBombAvaxCurve {
    using SafeERC20Upgradeable for IERC20Upgradeable;
    using SafeERC20Upgradeable for IWAVAX;

    function initialize(
        IPool _pool, IGauge _gauge,
        IERC20Upgradeable _rewardToken
    ) external initializer {
        __Ownable_init();

        pool = _pool;
        gauge = _gauge;
        lpToken = IERC20Upgradeable(pool.lp_token());

        yieldFeePerc = 500;
        slippagePerc = 50;
        treasury = owner();
        rewardToken = _rewardToken;
        tvlMaxLimit = 5000000e6;

        USDT.safeApprove(address(pool), type(uint).max);
        USDC.safeApprove(address(pool), type(uint).max);
        DAI.safeApprove(address(pool), type(uint).max);
        lpToken.safeApprove(address(pool), type(uint).max);
        lpToken.safeApprove(address(gauge), type(uint).max);
        WAVAX.safeApprove(address(router), type(uint).max);
        CRV.safeApprove(address(router), type(uint).max);
    }

    

    function claimReward(address account) public override {
        _harvest(false);

        User storage user = userInfo[account];
        if (user.lpTokenBalance > 0) {
            // Calculate user reward
            uint rewardTokenAmt = (user.lpTokenBalance * accRewardPerlpToken / 1e36) - user.rewardStartAt;
            if (rewardTokenAmt > 0) {
                user.rewardStartAt += rewardTokenAmt;

                // Transfer rewardToken to user
                rewardToken.safeTransfer(account, rewardTokenAmt);
                userAccReward[account] += rewardTokenAmt;

                emit ClaimReward(account, 0, rewardTokenAmt);
            }
        }
    }
}
