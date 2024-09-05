// SPDX-License-Identifier: MIT
pragma solidity >=0.6.10 <0.8.0;

import "./IPrimaryMarket.sol";

interface IPrimaryMarketV2 is IPrimaryMarket {
    function claimAndUnwrap(address account)
        external
        returns (uint256 redeemedUnderlying, uint256 createdShares);

    function updateDelayedRedemptionDay() external;
}
