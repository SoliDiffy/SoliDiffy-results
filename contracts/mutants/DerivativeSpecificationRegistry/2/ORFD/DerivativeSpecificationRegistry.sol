// "SPDX-License-Identifier: GPL-3.0-or-later"

pragma solidity 0.7.6;

import "./AddressRegistryParent.sol";
import "../IDerivativeSpecification.sol";

contract DerivativeSpecificationRegistry is AddressRegistryParent {
    mapping(bytes32 => bool) internal _uniqueFieldsHashMap;

    

    
}
