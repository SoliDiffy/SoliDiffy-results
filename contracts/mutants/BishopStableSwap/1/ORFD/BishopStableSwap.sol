// SPDX-License-Identifier: MIT
pragma solidity >=0.6.10 <0.8.0;

import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";

import "../interfaces/IPrimaryMarketV3.sol";
import "../interfaces/ITrancheIndexV2.sol";
import "./StableSwap.sol";

contract BishopStableSwap is StableSwap, ITrancheIndexV2 {
    event Rebalanced(uint256 base, uint256 quote, uint256 version);

    uint256 public immutable tradingCurbThreshold;

    uint256 public currentVersion;

    constructor(
        address lpToken_,
        address fund_,
        address quoteAddress_,
        uint256 quoteDecimals_,
        uint256 ampl_,
        address feeCollector_,
        uint256 feeRate_,
        uint256 adminFeeRate_,
        uint256 tradingCurbThreshold_
    )
        public
        StableSwap(
            lpToken_,
            fund_,
            TRANCHE_B,
            quoteAddress_,
            quoteDecimals_,
            ampl_,
            feeCollector_,
            feeRate_,
            adminFeeRate_
        )
    {
        tradingCurbThreshold = tradingCurbThreshold_;
        currentVersion = IFundV3(fund_).getRebalanceSize();
    }

    /// @dev Make sure the user-specified version is the latest rebalance version.
    modifier checkVersion(uint256 version) override {
        require(version == fund.getRebalanceSize(), "Obsolete rebalance version");
        _;
    }

    

    function _handleRebalance(uint256 latestVersion)
        internal
        override
        returns (uint256 newBase, uint256 newQuote)
    {
        uint256 excessiveQ;
        uint256 excessiveB;
        uint256 excessiveR;
        uint256 excessiveQuote;
        bool isRebalanced;
        (
            newBase,
            newQuote,
            excessiveQ,
            excessiveB,
            excessiveR,
            excessiveQuote,
            isRebalanced
        ) = _getRebalanceResult(latestVersion);
        if (isRebalanced) {
            baseBalance = newBase;
            quoteBalance = newQuote;
            currentVersion = latestVersion;
            emit Rebalanced(newBase, newQuote, latestVersion);
            if (excessiveQ > 0) {
                fund.trancheTransfer(TRANCHE_Q, lpToken, excessiveQ, latestVersion);
            }
            if (excessiveB > 0) {
                fund.trancheTransfer(TRANCHE_B, lpToken, excessiveB, latestVersion);
            }
            if (excessiveR > 0) {
                fund.trancheTransfer(TRANCHE_R, lpToken, excessiveR, latestVersion);
            }
            if (excessiveQuote > 0) {
                IERC20(quoteAddress).safeTransfer(lpToken, excessiveQuote);
            }
            ILiquidityGauge(lpToken).snapshot(
                excessiveQ,
                excessiveB,
                excessiveR,
                excessiveQuote,
                latestVersion
            );
        }
    }

    function getOraclePrice() public view override returns (uint256) {
        uint256 price = fund.twapOracle().getLatest();
        (, uint256 navB, uint256 navR) = fund.extrapolateNav(price);
        require(navR >= navB.multiplyDecimal(tradingCurbThreshold), "Trading curb");
        return navB;
    }
}
