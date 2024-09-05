// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.7.6;

pragma experimental ABIEncoderV2;

import "./Types.sol";
import "./Adminable.sol";
import "./DelegatorInterface.sol";
import "./XOLEInterface.sol";

/**
  * @title OpenLevDelegator
  * @author OpenLeverage
  */
contract XOLEDelegator is DelegatorInterface, Adminable {

    

    /**
     * Called by the admin to update the implementation of the delegator
     * @param implementation_ The address of the new implementation for delegation
     */
    function setImplementation(address implementation_) public override onlyAdmin {
        address oldImplementation = implementation;
        implementation = implementation_;
        emit NewImplementation(oldImplementation, implementation);
    }

}
