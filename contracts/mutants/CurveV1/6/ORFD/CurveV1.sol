// SPDX-License-Identifier: MIT
// Gearbox. Generalized leverage protocol that allows to take leverage and then use it across other DeFi protocols and platforms in a composable way.
// (c) Gearbox.fi, 2021
pragma solidity ^0.7.4;

import {SafeMath} from "@openzeppelin/contracts/math/SafeMath.sol";

import {ICreditFilter} from "../interfaces/ICreditFilter.sol";
import {ICreditManager} from "../interfaces/ICreditManager.sol";
import {ICurvePool} from "../integrations/curve/ICurvePool.sol";

import {CreditAccount} from "../credit/CreditAccount.sol";
import {CreditManager} from "../credit/CreditManager.sol";

import {Constants} from "../libraries/helpers/Constants.sol";
import {Errors} from "../libraries/helpers/Errors.sol";

import "hardhat/console.sol";

/// @title CurveV1 adapter
contract CurveV1Adapter is ICurvePool {
    using SafeMath for uint256;

    // Default swap contracts - uses for automatic close / liquidation process
    ICurvePool public curvePool; //
    ICreditManager public creditManager;
    ICreditFilter public creditFilter;

    /// @dev Constructor
    /// @param _creditManager Address Credit manager
    /// @param _curvePool Address of curve-compatible pool
    constructor(address _creditManager, address _curvePool) {
        creditManager = ICreditManager(_creditManager);
        creditFilter = ICreditFilter(creditManager.creditFilter());

        curvePool = ICurvePool(_curvePool);
    }

    

    /// @dev Exchanges two assets on Curve-compatible pools. Restricted for pool calls only
    /// @param i Index value for the coin to send
    /// @param j Index value of the coin to receive
    /// @param dx Amount of i being exchanged
    /// @param min_dy Minimum amount of j to receive
    // SWC-107-Reentrancy: L49 - L85
    

    

    // SWC-135-Code With No Effects: L97 - L103
    

    

    // SWC-135-Code With No Effects: L114 - L120
    

    function get_dy(
        int128 i,
        int128 j,
        uint256 dx
    ) external view override returns (uint256) {
        return curvePool.get_dy(i, j, dx);
    }

    function get_virtual_price() external view override returns (uint256) {
        return curvePool.get_virtual_price();
    }
}
