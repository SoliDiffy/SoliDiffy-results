// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

import "./PowerBombAvaxCurve.sol";

contract PowerBombFtmCurveGeist is PowerBombAvaxCurve {
    using SafeERC20Upgradeable for IERC20Upgradeable;

    IERC20Upgradeable constant fUSDT = IERC20Upgradeable(0x049d68029688eAbF473097a2fC38ef61633A3C7A);
    IERC20Upgradeable constant fUSDC = IERC20Upgradeable(0x04068DA6C83AFCFA0e13ba15A6696662335D5B75);
    IERC20Upgradeable constant fDAI = IERC20Upgradeable(0x8D11eC38a3EB5E956B052f67Da8Bdc9bef8Abf3E);
    IERC20Upgradeable constant WFTM = IERC20Upgradeable(0x21be370D5312f44cB42ce377BC9b8a0cEF1A4C83);
    IERC20Upgradeable constant GEIST = IERC20Upgradeable(0xd8321AA83Fb0a4ECd6348D4577431310A6E0814d);
    IERC20Upgradeable constant fCRV = IERC20Upgradeable(0x1E4F97b9f9F913c46F1632781732927B9019C68b);
    IRouter constant spookyRouter = IRouter(0xF491e7B69E4244ad4002BC14e878a34207E38c29);

    function initialize(
        IPool _pool, IGauge _gauge,
        IERC20Upgradeable _rewardToken, address _treasury
    ) external initializer {
        __Ownable_init();

        pool = _pool;
        gauge = _gauge;
        lpToken = IERC20Upgradeable(pool.lp_token());

        yieldFeePerc = 500;
        slippagePerc = 50;
        treasury = _treasury;
        rewardToken = _rewardToken;
        tvlMaxLimit = 5000000e6;

        fUSDT.safeApprove(address(pool), type(uint).max);
        fUSDC.safeApprove(address(pool), type(uint).max);
        fDAI.safeApprove(address(pool), type(uint).max);
        lpToken.safeApprove(address(pool), type(uint).max);
        lpToken.safeApprove(address(gauge), type(uint).max);
        WFTM.safeApprove(address(spookyRouter), type(uint).max);
        fCRV.safeApprove(address(spookyRouter), type(uint).max);
        GEIST.safeApprove(address(spookyRouter), type(uint).max);
    }

    

    

    

    

    

    uint256[50] private __gap;
}
