/**
 *  ParseIntScientific - The Consumer Contract Wallet
 *  Copyright (C) 2019 The Contract Wallet Company Limited
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.

 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.

 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

pragma solidity ^0.4.25;

import "../externals/SafeMath.sol";


/// @title ParseIntScientific provides floating point in scientific notation (e.g. e-5) parsing functionality.
contract ParseIntScientific {

    using SafeMath for uint256;

    byte constant private _PLUS_ASCII = byte(43); //decimal value of '+'
    byte constant private _DASH_ASCII = byte(45); //decimal value of '-'
    byte constant private _DOT_ASCII = byte(46); //decimal value of '.'
    byte constant private _ZERO_ASCII = byte(48); //decimal value of '0'
    byte constant private _NINE_ASCII = byte(57); //decimal value of '9'
    byte constant private _E_ASCII = byte(69); //decimal value of 'E'
    byte constant private _LOWERCASE_E_ASCII = byte(101); //decimal value of 'e'

    /// @notice ParseIntScientific delegates the call to _parseIntScientific(string, uint) with the 2nd argument being 0.
    

    /// @notice ParseIntScientificWei parses a rate expressed in ETH and returns its wei denomination
    function _parseIntScientificWei(string _inString) internal pure returns (uint) {
        return _parseIntScientific(_inString, 18);
    }

    /// @notice ParseIntScientific parses a JSON standard - floating point number.
    /// @param _inString is input string.
    /// @param _magnitudeMult multiplies the number with 10^_magnitudeMult.
    
}
