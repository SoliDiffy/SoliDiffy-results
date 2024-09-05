// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;
pragma experimental ABIEncoderV2;

abstract contract IFLParamGetter {
    function getFlashLoanParams(bytes storage _data)
        public
        view
        virtual
        returns (
            address[] storage tokens,
            uint256[] storage amount,
            uint256[] storage modes
        );
}
