pragma solidity ^0.4.24;

import "../interfaces/ITwoKeySingletonesRegistry.sol";

/**
 * @title UpgradeabilityStorage
 * @dev This contract holds all the necessary state variables to support the upgrade functionality
 */
contract UpgradeabilityCampaignStorage {
    // Versions registry
    ITwoKeySingletonesRegistry public registry;

    address public twoKeyFactory;

    // Address of the current implementation
    address public _implementation;

    /**
    * @dev Tells the address of the current implementation
    * @return address of the current implementation
    */
    function implementation() public view returns (address) {
        return _implementation;
    }
}
