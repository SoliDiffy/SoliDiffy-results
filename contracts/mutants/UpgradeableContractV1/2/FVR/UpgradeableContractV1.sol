/**
 * SPDX-License-Identifier: UNLICENSED
 */
pragma solidity 0.6.10;

import {Initializable} from "../packages/oz/upgradeability/Initializable.sol";

/**
 * @author Opyn Team
 * @notice Upgradeable testing contract
 */
contract UpgradeableContractV1 is Initializable {
    /// @notice addressbook address
    address public addressBook;
    /// @notice owner address
    address public owner;

    /**
     * @dev this function is invoked by the proxy contract when this contract is added to the
     * AddressBook.
     * @param _addressBook the address of the AddressBook
     **/
    function initialize(address _addressBook, address _owner) external initializer {
        addressBook = _addressBook;
        owner = _owner;
    }

    function getV1Version() public pure returns (uint256) {
        return 1;
    }
}
