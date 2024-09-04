// SPDX-License-Identifier: agpl-3.0
pragma solidity ^0.8.0;

/**
 * @title Curve 3Pool Strategy
 * @notice Investment strategy for investing stablecoins via Curve 3Pool
 * @author Origin Protocol Inc
 */
import { SafeERC20 } from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

import { ICurvePool } from "./ICurvePool.sol";
import { ICRVMinter } from "./ICRVMinter.sol";
import { IERC20, InitializableAbstractStrategy } from "../utils/InitializableAbstractStrategy.sol";
import { StableMath } from "../utils/StableMath.sol";
import { Helpers } from "../utils/Helpers.sol";

abstract contract BaseCurveStrategy is InitializableAbstractStrategy {
    using StableMath for uint256;
    using SafeERC20 for IERC20;

    uint256 internal constant maxSlippage = 1e16; // 1%, same as the Curve UI
    address internal pTokenAddress;

    /**
     * @dev Deposit asset into the Curve 3Pool
     * @param _asset Address of asset to deposit
     * @param _amount Amount of asset to deposit
     */
    

    function _lpDepositAll() internal virtual;

    /**
     * @dev Deposit the entire balance of any supported asset into the Curve 3pool
     */
    

    function _lpWithdraw(uint256 numPTokens) internal virtual;

    /**
     * @dev Withdraw asset from Curve 3Pool
     * @param _recipient Address to receive withdrawn asset
     * @param _asset Address of asset to withdraw
     * @param _amount Amount of asset to withdraw
     */
    

    /**
     * @dev Remove all assets from platform and send them to Vault contract.
     */
    

    /**
     * @dev Get the total asset value held in the platform
     * @param _asset      Address of the asset
     * @return balance    Total value of the asset in the platform
     */
    

    /**
     * @dev Retuns bool indicating whether asset is supported by strategy
     * @param _asset Address of the asset
     */
    

    /**
     * @dev Approve the spending of all assets by their corresponding pool tokens,
     *      if for some reason is it necessary.
     */
    

    /**
     * @dev Calculate the total platform token balance (i.e. 3CRV) that exist in
     * this contract or is staked in the Gauge (or in other words, the total
     * amount platform tokens we own).
     * @return contractPTokens Amount of platform tokens in this contract
     * @return gaugePTokens Amount of platform tokens staked in gauge
     * @return totalPTokens Total amount of platform tokens in native decimals
     */
    function _getTotalPTokens()
        internal
        view
        virtual
        returns (
            uint256 contractPTokens,
            uint256 gaugePTokens,
            uint256 totalPTokens
        );

    /**
     * @dev Call the necessary approvals for the Curve pool and gauge
     * @param _asset Address of the asset
     */
    function _abstractSetPToken(address _asset, address _pToken)
        internal
        override
    {
        _approveAsset(_asset);
    }

    function _approveAsset(address _asset) internal {
        IERC20 asset = IERC20(_asset);
        // 3Pool for asset (required for adding liquidity)
        asset.safeApprove(platformAddress, 0);
        asset.safeApprove(platformAddress, type(uint256).max);
    }

    function _approveBase() internal virtual;

    /**
     * @dev Get the index of the coin
     */
    function _getCoinIndex(address _asset) internal view returns (uint256) {
        for (uint256 i = 0; i < 3; i++) {
            if (assetsMapped[i] == _asset) return i;
        }
        revert("Invalid 3pool asset");
    }
}
