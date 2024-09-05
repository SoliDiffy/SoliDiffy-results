pragma solidity ^0.5.16;

import "../BinaryOptionMarket.sol";
import "../AddressResolver.sol";

contract MockBinaryOptionMarketManager {
    BinaryOptionMarket public market;
    bool public paused = false;

    function createMarket(
        AddressResolver resolver,
        address creator,
        uint[2] calldata creatorLimits,
        bytes32 oracleKey,
        uint strikePrice,
        bool refundsEnabled,
        uint[3] calldata times, // [biddingEnd, maturity, expiry]
        uint[2] calldata bids, // [longBid, shortBid]
        uint[3] calldata fees // [poolFee, creatorFee, refundFee]
    ) public {
        market = new BinaryOptionMarket(
            address(this),
            creator,
            address(resolver),
            creatorLimits,
            oracleKey,
            strikePrice,
            refundsEnabled,
            times,
            bids,
            fees
        );
        market.rebuildCache();
    }

    function decrementTotalDeposited(uint) public pure {
        return;
    }

    function resolveMarket() public {
        market.resolve();
    }

    function durations()
        public
        pure
        returns (
            uint,
            uint,
            uint
        )
    {
        return (60 * 60 * 24, 0, 0);
    }
}
