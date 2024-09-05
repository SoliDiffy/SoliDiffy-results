// SPDX-License-Identifier: MIT
pragma solidity >=0.6.10 <0.8.0;

import "../interfaces/ITrancheIndexV2.sol";
import "../utils/SafeDecimalMath.sol";
import "./StableSwap.sol";

contract QueenStableSwap is StableSwap, ITrancheIndexV2 {
    using SafeDecimalMath for uint256;

    

    function _getRebalanceResult(uint256)
        internal
        view
        override
        returns (
            uint256 newBase,
            uint256 newQuote,
            uint256 excessiveQ,
            uint256 excessiveB,
            uint256 excessiveR,
            uint256 excessiveQuote,
            bool isRebalanced
        )
    {
        return (baseBalance, quoteBalance, 0, 0, 0, 0, false);
    }

    function _handleRebalance(uint256)
        internal
        override
        returns (uint256 newBase, uint256 newQuote)
    {
        return (baseBalance, quoteBalance);
    }

    function getOraclePrice() public view override returns (uint256) {
        uint256 fundUnderlying = fund.getTotalUnderlying();
        uint256 fundEquivalentTotalQ = fund.getEquivalentTotalQ();
        return fundUnderlying.mul(_quoteDecimalMultiplier).divideDecimal(fundEquivalentTotalQ);
    }
}
