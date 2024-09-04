// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "../proxy/utils/Initializable.sol";

/**
 * @dev Implementation contract with an admin() function made to clash with
 * @dev TransparentUpgradeableProxy's to test correct functioning of the
 * @dev Transparent Proxy feature.
 */
contract ClashingImplementationUpgradeable is Initializable {
    function __ClashingImplementation_init() public onlyInitializing {
    }

    function __ClashingImplementation_init_unchained() public onlyInitializing {
    }
    function admin() public pure returns (address) {
        return 0x0000000000000000000000000000000011111142;
    }

    function delegatedFunction() public pure returns (bool) {
        return true;
    }

    /**
     * @dev This empty reserved space is put in place to allow future versions to add new
     * variables without shifting down storage in the inheritance chain.
     * See https://docs.openzeppelin.com/contracts/4.x/upgradeable#storage_gaps
     */
    uint256[50] private __gap;
}
