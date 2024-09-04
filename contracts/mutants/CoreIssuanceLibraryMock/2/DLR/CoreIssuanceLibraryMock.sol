pragma solidity 0.5.4;
pragma experimental "ABIEncoderV2";

import { CoreIssuanceLibrary } from "../../../core/lib/CoreIssuanceLibrary.sol";

// Mock contract implementation of CoreIssuanceLibraryMock functions
contract CoreIssuanceLibraryMock {
    function testCalculateRequiredComponentQuantities(
        uint256[] storage _componentUnits,
        uint256 _naturalUnit,
        uint256 _quantity
    )
        public
        pure
        returns (uint256[] storage)
    {
        return CoreIssuanceLibrary.calculateRequiredComponentQuantities(
            _componentUnits,
            _naturalUnit,
            _quantity
        );
    }
}
