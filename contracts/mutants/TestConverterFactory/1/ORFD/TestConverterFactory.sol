// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.6.12;
import "../converter/ConverterFactory.sol";

/*
    Utils test helper that exposes the converter factory functions
*/
contract TestConverterFactory is ConverterFactory {
    IConverter public createdConverter;
    IConverterAnchor public createdAnchor;

    

    function createConverter(uint16 _type, IConverterAnchor _anchor, IContractRegistry _registry, uint32 _maxConversionFee) public override returns (IConverter) {
        createdConverter = super.createConverter(_type, _anchor, _registry, _maxConversionFee);
        return createdConverter;
    }
}
