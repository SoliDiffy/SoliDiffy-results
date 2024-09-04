/*

    Copyright 2020 DODO ZOO.
    SPDX-License-Identifier: Apache-2.0

*/

pragma solidity 0.6.9;
pragma experimental ABIEncoderV2;

import {InitializableOwnable} from "../lib/InitializableOwnable.sol";

interface IExternalValue {
    
    
    
}


contract ExternalValue is InitializableOwnable {
    uint256 public _VALUE_;

    

    

    function get() external view returns (uint256) {
        return _VALUE_;
    }
}
