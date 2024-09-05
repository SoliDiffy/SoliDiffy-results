// SPDX-License-Identifier: AGPL-3.0-only

pragma solidity 0.8.10;

import {IReferenceModule} from '../interfaces/IReferenceModule.sol';

contract MockReferenceModule is IReferenceModule {
    

    

    function processMirror(
        uint256 profileId,
        uint256 profileIdPointed,
        uint256 pubIdPointed
    ) external override {}
}
