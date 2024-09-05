// SPDX-License-Identifier: MIT

pragma solidity 0.8.4;

import "../IFundsHandler.sol";
import "../IFundsDrainable.sol";

/**
 * Allows funds to be split using a pull pattern, holding a balance until drained
 */

// FIXME use a single contract as a registry for splits rather than one per collab split
contract FundsReceiver is IFundsHandler, IFundsDrainable {

    bool private _notEntered = true;

    /** @dev Prevents a contract from calling itself, directly or indirectly. */
    modifier nonReentrant() {
        require(_notEntered, "ReentrancyGuard: reentrant call");
        _notEntered = false;
        _;
        _notEntered = true;
    }

    bool private locked;
    address[] public recipients;
    uint256[] public splits;

    /**
     * @notice Using a minimal proxy contract pattern initialises the contract and sets delegation
     * @dev initialises the FundsReceiver (see https://eips.ethereum.org/EIPS/eip-1167)
     */
    

    // accept all funds
    receive() external payable {}

    

    

    function royaltyAtIndex(uint256 _index) public override view returns (address recipient, uint256 split) {
        recipient = recipients[_index];
        split = splits[_index];
    }
}
