// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.6.12;
import "../converter/ConverterRegistry.sol";

/*
    Utils test helper that exposes the converter registry functions
*/
contract TestConverterRegistry is ConverterRegistry {
    IConverter public createdConverter;

    constructor(IContractRegistry _registry) public ConverterRegistry(_registry) {
    }

    
}
