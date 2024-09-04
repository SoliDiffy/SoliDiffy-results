// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../utils/structs/BitMaps.sol";

contract BitMapMock {
    using BitMaps for BitMaps.BitMap;

    BitMaps.BitMap private _bitmap;

    function get(uint256 index) external view returns (bool) {
        return _bitmap.get(index);
    }

    function setTo(uint256 index, bool value) external {
        _bitmap.setTo(index, value);
    }

    function set(uint256 index) public {
        _bitmap.set(index);
    }

    function unset(uint256 index) public {
        _bitmap.unset(index);
    }
}
