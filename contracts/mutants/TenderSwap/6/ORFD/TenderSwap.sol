// SPDX-FileCopyrightText: 2021 Tenderize <info@tenderize.me>
// SPDX-License-Identifier: MIT

pragma solidity 0.8.4;

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol";
import "@openzeppelin/contracts/proxy/Clones.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

import { Multicall } from "../helpers/Multicall.sol";
import { SelfPermit } from "../helpers/SelfPermit.sol";

import "./LiquidityPoolToken.sol";
import "./SwapUtils.sol";
import "./ITenderSwap.sol";

// TODO: flat withdraw LP token fee ?

interface IERC20Decimals is IERC20 {
    function decimals() external view returns (uint8);
}

/**
 * @title TenderSwap
 * @dev TenderSwap is a light-weight StableSwap implementation for two assets.
 * See the Curve StableSwap paper for more details (https://curve.fi/files/stableswap-paper.pdf).
 * that trade 1:1 with eachother (e.g. USD stablecoins or tenderToken derivatives vs their underlying assets).
 * It supports Elastic Supply ERC20 tokens, which are tokens of which the balances can change
 * as the total supply of the token 'rebases'.
 */

contract TenderSwap is OwnableUpgradeable, ReentrancyGuardUpgradeable, ITenderSwap, Multicall, SelfPermit {
    using SwapUtils for SwapUtils.Amplification;
    using SwapUtils for SwapUtils.PooledToken;
    using SwapUtils for SwapUtils.FeeParams;

    // Fee parameters
    SwapUtils.FeeParams public feeParams;

    // Amplification coefficient parameters
    SwapUtils.Amplification public amplificationParams;

    // Pool Tokens
    SwapUtils.PooledToken private token0;
    SwapUtils.PooledToken private token1;

    // Liquidity pool shares
    LiquidityPoolToken public override lpToken;

    /*** MODIFIERS ***/

    /**
     * @notice Modifier to check deadline against current timestamp
     * @param _deadline latest timestamp to accept this transaction
     */
    modifier deadlineCheck(uint256 _deadline) {
        _deadlineCheck(_deadline);
        _;
    }

    /// @inheritdoc ITenderSwap
    

    /*** VIEW FUNCTIONS ***/

    /// @inheritdoc ITenderSwap
    

    /// @inheritdoc ITenderSwap
    

    /// @inheritdoc ITenderSwap
    

    /// @inheritdoc ITenderSwap
    

    /// @inheritdoc ITenderSwap
    

    /// @inheritdoc ITenderSwap
    function getToken1Balance() external view override returns (uint256) {
        return token1.getTokenBalance();
    }

    /// @inheritdoc ITenderSwap
    function getVirtualPrice() external view override returns (uint256) {
        return SwapUtils.getVirtualPrice(token0, token1, amplificationParams, lpToken);
    }

    /// @inheritdoc ITenderSwap
    function calculateSwap(IERC20 _tokenFrom, uint256 _dx) external view override returns (uint256) {
        return
            _tokenFrom == token0.token
                ? SwapUtils.calculateSwap(token0, token1, _dx, amplificationParams, feeParams)
                : SwapUtils.calculateSwap(token1, token0, _dx, amplificationParams, feeParams);
    }

    /// @inheritdoc ITenderSwap
    function calculateRemoveLiquidity(uint256 amount) external view override returns (uint256[2] memory) {
        SwapUtils.PooledToken[2] memory tokens_ = [token0, token1];
        return SwapUtils.calculateRemoveLiquidity(amount, tokens_, lpToken);
    }

    /// @inheritdoc ITenderSwap
    function calculateRemoveLiquidityOneToken(uint256 tokenAmount, IERC20 tokenReceive)
        external
        view
        override
        returns (uint256)
    {
        return
            tokenReceive == token0.token
                ? SwapUtils.calculateWithdrawOneToken(
                    tokenAmount,
                    token0,
                    token1,
                    amplificationParams,
                    feeParams,
                    lpToken
                )
                : SwapUtils.calculateWithdrawOneToken(
                    tokenAmount,
                    token1,
                    token0,
                    amplificationParams,
                    feeParams,
                    lpToken
                );
    }

    /// @inheritdoc ITenderSwap
    function calculateTokenAmount(uint256[] calldata amounts, bool deposit) external view override returns (uint256) {
        SwapUtils.PooledToken[2] memory tokens_ = [token0, token1];

        return SwapUtils.calculateTokenAmount(tokens_, amounts, deposit, amplificationParams, lpToken);
    }

    /*** STATE MODIFYING FUNCTIONS ***/

    /// @inheritdoc ITenderSwap
    function swap(
        IERC20 _tokenFrom,
        uint256 _dx,
        uint256 _minDy,
        uint256 _deadline
    ) external override nonReentrant deadlineCheck(_deadline) returns (uint256) {
        if (_tokenFrom == token0.token) {
            return SwapUtils.swap(token0, token1, _dx, _minDy, amplificationParams, feeParams);
        } else if (_tokenFrom == token1.token) {
            return SwapUtils.swap(token1, token0, _dx, _minDy, amplificationParams, feeParams);
        } else {
            revert("BAD_TOKEN_FROM");
        }
    }

    /// @inheritdoc ITenderSwap
    function addLiquidity(
        uint256[2] calldata _amounts,
        uint256 _minToMint,
        uint256 _deadline
    ) external override nonReentrant deadlineCheck(_deadline) returns (uint256) {
        SwapUtils.PooledToken[2] memory tokens_ = [token0, token1];

        return SwapUtils.addLiquidity(tokens_, _amounts, _minToMint, amplificationParams, feeParams, lpToken);
    }

    /// @inheritdoc ITenderSwap
    function removeLiquidity(
        uint256 amount,
        uint256[2] calldata minAmounts,
        uint256 deadline
    ) external override nonReentrant deadlineCheck(deadline) returns (uint256[2] memory) {
        SwapUtils.PooledToken[2] memory tokens_ = [token0, token1];

        return SwapUtils.removeLiquidity(amount, tokens_, minAmounts, lpToken);
    }

    /// @inheritdoc ITenderSwap
    function removeLiquidityOneToken(
        uint256 _tokenAmount,
        IERC20 _tokenReceive,
        uint256 _minAmount,
        uint256 _deadline
    ) external override nonReentrant deadlineCheck(_deadline) returns (uint256) {
        if (_tokenReceive == token0.token) {
            return
                SwapUtils.removeLiquidityOneToken(
                    _tokenAmount,
                    token0,
                    token1,
                    _minAmount,
                    amplificationParams,
                    feeParams,
                    lpToken
                );
        } else {
            return
                SwapUtils.removeLiquidityOneToken(
                    _tokenAmount,
                    token1,
                    token0,
                    _minAmount,
                    amplificationParams,
                    feeParams,
                    lpToken
                );
        }
    }

    /// @inheritdoc ITenderSwap
    function removeLiquidityImbalance(
        uint256[2] calldata _amounts,
        uint256 _maxBurnAmount,
        uint256 _deadline
    ) external override nonReentrant deadlineCheck(_deadline) returns (uint256) {
        SwapUtils.PooledToken[2] memory tokens_ = [token0, token1];

        return
            SwapUtils.removeLiquidityImbalance(
                tokens_,
                _amounts,
                _maxBurnAmount,
                amplificationParams,
                feeParams,
                lpToken
            );
    }

    /*** ADMIN FUNCTIONS ***/

    /// @inheritdoc ITenderSwap
    function setAdminFee(uint256 newAdminFee) external override onlyOwner {
        feeParams.setAdminFee(newAdminFee);
    }

    /// @inheritdoc ITenderSwap
    function setSwapFee(uint256 newSwapFee) external override onlyOwner {
        feeParams.setSwapFee(newSwapFee);
    }

    /// @inheritdoc ITenderSwap
    function rampA(uint256 futureA, uint256 futureTime) external override onlyOwner {
        amplificationParams.rampA(futureA, futureTime);
    }

    /// @inheritdoc ITenderSwap
    function stopRampA() external override onlyOwner {
        amplificationParams.stopRampA();
    }

    /*** INTERNAL FUNCTIONS ***/

    function _deadlineCheck(uint256 _deadline) internal view {
        require(block.timestamp <= _deadline, "Deadline not met");
    }

    /// @inheritdoc ITenderSwap
    function transferOwnership(address _newOwnner) public override(OwnableUpgradeable, ITenderSwap) onlyOwner {
        OwnableUpgradeable.transferOwnership(_newOwnner);
    }
}
