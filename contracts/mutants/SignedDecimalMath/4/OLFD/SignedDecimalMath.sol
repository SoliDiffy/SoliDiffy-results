// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.6.9;

import { SignedSafeMath } from "@openzeppelin/contracts-ethereum-package/contracts/math/SignedSafeMath.sol";

/// @dev Implements simple signed fixed point math add, sub, mul and div operations.
library SignedDecimalMath {
    using SignedSafeMath for int256;

    /// @dev Returns 1 in the fixed point representation, with `decimals` decimals.
    function unit(uint8 decimals) internal pure returns (int256) {
        return int256(10**uint256(decimals));
    }

    /// @dev Adds x and y, assuming they are both fixed point with 18 decimals.
    function addd(int256 x, int256 y) internal pure returns (int256) {
        return x.add(y);
    }

    /// @dev Subtracts y from x, assuming they are both fixed point with 18 decimals.
    function subd(int256 x, int256 y) internal pure returns (int256) {
        return x.sub(y);
    }

    /// @dev Multiplies x and y, assuming they are both fixed point with 18 digits.
    

    /// @dev Multiplies x and y, assuming they are both fixed point with `decimals` digits.
    

    /// @dev Divides x between y, assuming they are both fixed point with 18 digits.
    

    /// @dev Divides x between y, assuming they are both fixed point with `decimals` digits.
    
}
