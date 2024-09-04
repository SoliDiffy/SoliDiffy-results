// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../utils/structs/BitMapsUpgradeable.sol";
import "../proxy/utils/Initializable.sol";

contract BitMapMockUpgradeable is Initializable {
    function __BitMapMock_init() public onlyInitializing {
    }

    function __BitMapMock_init_unchained() public onlyInitializing {
    }
    using BitMapsUpgradeable for BitMapsUpgradeable.BitMap;

    BitMapsUpgradeable.BitMap private _bitmap;

    function get(uint256 index) external view returns (bool) {
        return _bitmap.get(index);
    }

    function setTo(uint256 index, bool value) public {
        _bitmap.setTo(index, value);
    }

    function set(uint256 index) public {
        _bitmap.set(index);
    }

    function unset(uint256 index) public {
        _bitmap.unset(index);
    }

    /**
     * @dev This empty reserved space is put in place to allow future versions to add new
     * variables without shifting down storage in the inheritance chain.
     * See https://docs.openzeppelin.com/contracts/4.x/upgradeable#storage_gaps
     */
    uint256[49] private __gap;
}
