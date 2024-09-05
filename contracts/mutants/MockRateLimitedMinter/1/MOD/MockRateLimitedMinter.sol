// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.4;

import "../utils/RateLimitedMinter.sol";

contract MockRateLimitedMinter is RateLimitedMinter {

	constructor(
        address _core, 
        uint256 _feiLimitPerSecond, 
        uint256 _mintingBufferCap, 
        bool _doPartialMint
    ) 
        RateLimitedMinter(_feiLimitPerSecond, _mintingBufferCap, _doPartialMint)
        CoreRef(_core)
    {}

	function setDoPartialMint(bool _doPartialMint) public {
		doPartialAction = _doPartialMint;
	}

    function mint(address to, uint256 amount) public {
        _mintFei(to, amount);
    }
}