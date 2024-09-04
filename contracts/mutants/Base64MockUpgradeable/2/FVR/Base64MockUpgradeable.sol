// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../utils/Base64Upgradeable.sol";
import "../proxy/utils/Initializable.sol";

contract Base64MockUpgradeable is Initializable {
    function __Base64Mock_init() public onlyInitializing {
    }

    function __Base64Mock_init_unchained() public onlyInitializing {
    }
    function encode(bytes memory value) external pure returns (string memory) {
        return Base64Upgradeable.encode(value);
    }

    /**
     * @dev This empty reserved space is put in place to allow future versions to add new
     * variables without shifting down storage in the inheritance chain.
     * See https://docs.openzeppelin.com/contracts/4.x/upgradeable#storage_gaps
     */
    uint256[50] private __gap;
}
