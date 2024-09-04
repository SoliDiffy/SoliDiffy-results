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

    

    

    function getOraclePrice() public view override returns (uint256) {
        uint256 price = fund.twapOracle().getLatest();
        (, uint256 navB, uint256 navR) = fund.extrapolateNav(price);
        require(navR >= navB.multiplyDecimal(tradingCurbThreshold), "Trading curb");
        return navB;
    }
}
