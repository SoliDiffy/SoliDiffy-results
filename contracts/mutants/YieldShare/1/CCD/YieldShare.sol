// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.6;

import "./PoolShare.sol";

/// @dev Token representing the yield shares of a pool.
contract YieldShare is PoolShare {
    // solhint-disable-next-line no-empty-blocks
    

    function getPricePerFullShare() external override returns (uint256) {
        return pool.pricePerYieldShare();
    }

    function getPricePerFullShareStored() external view override returns (uint256) {
        return pool.pricePerYieldShareStored();
    }
}
