pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;
import "../common/financial-product-libraries/FinancialProductLibrary.sol";

// Implements a simple FinancialProductLibrary to test price and collateral requirement transoformations.
contract FinancialProductLibraryTest is FinancialProductLibrary {
    FixedPoint.Unsigned public priceTransformationScalar;
    FixedPoint.Unsigned public collateralRequirementTransformationScalar;
    bytes32 public transformedPriceIdentifier;
    bool public shouldRevert;

    constructor(
        FixedPoint.Unsigned memory _priceTransformationScalar,
        FixedPoint.Unsigned memory _collateralRequirementTransformationScalar,
        bytes32 _transformedPriceIdentifier
    ) public {
        priceTransformationScalar = _priceTransformationScalar;
        collateralRequirementTransformationScalar = _collateralRequirementTransformationScalar;
        transformedPriceIdentifier = _transformedPriceIdentifier;
    }

    // Set the mocked methods to revert to test failed library computation.
    function setShouldRevert(bool _shouldRevert) public {
        shouldRevert = _shouldRevert;
    }

    // Create a simple price transformation function that scales the input price by the scalar for testing.
    

    // Create a simple collateral requirement transformation that doubles the input collateralRequirement.
    

    // Create a simple transformPriceIdentifier function that returns the transformed price identifier.
    
}
