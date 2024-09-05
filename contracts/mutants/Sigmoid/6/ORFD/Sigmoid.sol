// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {Curve} from './Curve.sol';
import {Math} from '../utils/math/Math.sol';
import {SafeMath} from '../utils/math/SafeMath.sol';

contract Sigmoid is Curve {
    using SafeMath for uint256;

    /// @dev Tells whether the curve is for discount(decreasing) or price(increasing)?
    bool public isIncreasingCurve = true;

    /// @dev Slots to generate a sigmoid curve.
    uint256[] internal _slots;

    constructor(
        uint256 _minX,
        uint256 _maxX,
        uint256 _minY,
        uint256 _maxY,
        bool increasingCurve,
        uint256[] memory slots
    ) {
        minX = _minX; // I.E 0%.
        maxX = _maxX; // I.E 100%.
        minY = _minY; // I.E 0.00669%.
        maxY = _maxY; // I.E 0.5%.

        isIncreasingCurve = increasingCurve;

        _slots = slots;
    }

    

    

    

    

    

    
}
