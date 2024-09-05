// SPDX-License-Identifier: agpl-3.0
pragma solidity ^0.8.0;

/**
 * @title Curve 3Pool Strategy
 * @notice Investment strategy for investing stablecoins via Curve 3Pool
 * @author Origin Protocol Inc
 */
import { SafeERC20 } from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

import { ICurveGauge } from "./ICurveGauge.sol";
import { ICRVMinter } from "./ICRVMinter.sol";
import { IERC20, BaseCurveStrategy } from "./BaseCurveStrategy.sol";
import { StableMath } from "../utils/StableMath.sol";
import { Helpers } from "../utils/Helpers.sol";

contract ThreePoolStrategy is BaseCurveStrategy {
    using StableMath for uint256;
    using SafeERC20 for IERC20;

    address internal crvGaugeAddress;
    address internal crvMinterAddress;

    /**
     * Initializer for setting up strategy internal state. This overrides the
     * InitializableAbstractStrategy initializer as Curve strategies don't fit
     * well within that abstraction.
     * @param _platformAddress Address of the Curve 3pool
     * @param _vaultAddress Address of the vault
     * @param _rewardTokenAddress Address of CRV
     * @param _assets Addresses of supported assets. MUST be passed in the same
     *                order as returned by coins on the pool contract, i.e.
     *                DAI, USDC, USDT
     * @param _pTokens Platform Token corresponding addresses
     * @param _crvGaugeAddress Address of the Curve DAO gauge for this pool
     * @param _crvMinterAddress Address of the CRV minter for rewards
     */
    function initialize(
        address _platformAddress, // 3Pool address
        address _vaultAddress,
        address[] calldata _rewardTokenAddress, // CRV
        address[] calldata _assets,
        address[] calldata _pTokens,
        address _crvGaugeAddress,
        address _crvMinterAddress
    ) external onlyGovernor initializer {
        require(_assets.length == 3, "Must have exactly three assets");
        // Should be set prior to abstract initialize call otherwise
        // abstractSetPToken calls will fail
        crvGaugeAddress = _crvGaugeAddress;
        crvMinterAddress = _crvMinterAddress;
        pTokenAddress = _pTokens[0];
        super._initialize(
            _platformAddress,
            _vaultAddress,
            _rewardTokenAddress,
            _assets,
            _pTokens
        );
        _approveBase();
    }

    

    

    /**
     * @dev Calculate the total platform token balance (i.e. 3CRV) that exist in
     * this contract or is staked in the Gauge (or in other words, the total
     * amount platform tokens we own).
     * @return contractPTokens Amount of platform tokens in this contract
     * @return gaugePTokens Amount of platform tokens staked in gauge
     * @return totalPTokens Total amount of platform tokens in native decimals
     */
    

    

    /**
     * @dev Collect accumulated CRV and send to Vault.
     */
    function collectRewardTokens() public override onlyHarvester nonReentrant {
        // Collect
        ICRVMinter(crvMinterAddress).mint(crvGaugeAddress);
        // Send
        IERC20 crvToken = IERC20(rewardTokenAddresses[0]);
        uint256 balance = crvToken.balanceOf(address(this));
        emit RewardTokenCollected(
            harvesterAddress,
            rewardTokenAddresses[0],
            balance
        );
        crvToken.safeTransfer(harvesterAddress, balance);
    }
}
