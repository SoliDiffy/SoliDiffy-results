pragma solidity 0.5.4;

import { CommonValidationsLibrary } from "../../lib/CommonValidationsLibrary.sol";

contract CommonValidationsLibraryMock {
    function testValidateNonEmpty(
        address[] calldata _arr1
    )
        public
        pure
    {
        CommonValidationsLibrary.validateNonEmpty(_arr1);
    }

    function testValidateEqualLength(
        address[] calldata _addressArray,
        uint256[] calldata _uint256Array
    )
        public
        pure
    {
        CommonValidationsLibrary.validateEqualLength(_addressArray, _uint256Array);
    }
}
