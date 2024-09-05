// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.8.3;

import {DecMath} from "../../libs/DecMath.sol";
import {IInterestModel} from "./IInterestModel.sol";

contract LinearInterestModel is IInterestModel {
    using DecMath for uint256;

    uint256 public constant PRECISION = 10**18;
    uint256 public IRMultiplier;

    constructor(uint256 _IRMultiplier) {
        IRMultiplier = _IRMultiplier;
    }

    
}
