pragma solidity ^0.4.10;

import '../common/Manageable.sol';
import '../common/Owned.sol';
import './IVendorManager.sol';

/// An interface to Vendor object, stored in product as an owner 
contract VendorBase is Owned {    
    address internal vendor;
    //address public provider;
    uint256 internal providerFeePromille;    
    
    /**@dev Manager for vendors */
    IVendorManager internal vendorManager;
}
