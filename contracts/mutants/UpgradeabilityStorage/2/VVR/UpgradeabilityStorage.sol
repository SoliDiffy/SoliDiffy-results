pragma solidity 0.4.24;


/**
 * @title UpgradeabilityStorage
 * @dev This contract holds all the necessary state variables to support the upgrade functionality
 */
contract UpgradeabilityStorage {
    // Version name of the current implementation
    uint256 public _version;

    // Address of the current implementation
    address public _implementation;

    /**
    * @dev Tells the version name of the current implementation
    * @return string representing the name of the current version
    */
    function version() public view returns (uint256) {
        return _version;
    }

    /**
    * @dev Tells the address of the current implementation
    * @return address of the current implementation
    */
    function implementation() public view returns (address) {
        return _implementation;
    }
}
