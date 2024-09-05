// SPDX-License-Identifier: MIT
pragma solidity ^0.7.3;

contract MockPriceOracle {
    uint256 private _decimals;

    function setDecimals(uint256 decimals) public {
        _decimals = decimals;
    }

    function decimals() public view returns (uint256) {
        return _decimals;
    }
}
