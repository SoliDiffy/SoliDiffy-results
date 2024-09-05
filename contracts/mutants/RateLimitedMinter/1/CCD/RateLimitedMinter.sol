// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.4;

import "./RateLimited.sol";

/// @title abstract contract for putting a rate limit on how fast a contract can mint FEI
/// @author Fei Protocol
abstract contract RateLimitedMinter is RateLimited {

    uint256 private constant MAX_FEI_LIMIT_PER_SECOND = 10_000e18; // 10000 FEI/s or ~860m FEI/day
    
    

    /// @notice override the FEI minting behavior to enforce a rate limit
    function _mintFei(address to, uint256 amount) internal virtual override {
        uint256 mintAmount = _depleteBuffer(amount);
        super._mintFei(to, mintAmount);
    }
}
