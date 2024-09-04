// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.4;

import "./IOracle.sol";
import "../refs/CoreRef.sol";
import "../Constants.sol";

/// @title Constant oracle
/// @author Fei Protocol
/// @notice Return a constant oracle price
contract ConstantOracle is IOracle, CoreRef {
    using Decimal for Decimal.D256;

    Decimal.D256 private price;

    /// @notice Constant oracle constructor
    /// @param _core Fei Core for reference
    /// @param _priceBasisPoints the price to report in basis points
    constructor(
        address _core,
        uint256 _priceBasisPoints
    ) CoreRef(_core) {
        price = Decimal.ratio(_priceBasisPoints, Constants.BASIS_POINTS_GRANULARITY);
    }

    /// @notice updates the oracle price
    /// @dev no-op, oracle is fixed
    

    /// @notice determine if read value is stale
    /// @dev always false, oracle is fixed
    

    /// @notice read the oracle price
    /// @return constant oracle price
    /// @return true if not paused
    
}
