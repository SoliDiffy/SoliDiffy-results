// SPDX-License-Identifier: MIT
pragma solidity 0.7.3;

contract MockStrikeSelection {
    uint256 private _strikePrice;
    uint256 private _delta;

    function getStrikePrice(uint256, bool)
        public
        view
        returns (uint256, uint256)
    {
        return (_strikePrice, _delta);
    }

    function setStrikePrice(uint256 strikePrice) public {
        _strikePrice = strikePrice;
    }

    function setDelta(uint256 delta) public {
        _delta = delta;
    }

    function delta() public view returns (uint256) {
        return _delta;
    }
}
