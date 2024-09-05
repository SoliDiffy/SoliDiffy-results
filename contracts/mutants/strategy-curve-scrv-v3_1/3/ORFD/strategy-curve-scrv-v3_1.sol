// SPDX-License-Identifier: MIT
pragma solidity ^0.6.2;

import "../../lib/erc20.sol";
import "../../lib/safe-math.sol";

// SWC-135-Code With No Effects: L8
import "./scrv-voter.sol";
import "./crv-locker.sol";

import "../../interfaces/jar.sol";
import "../../interfaces/curve.sol";
import "../../interfaces/uniswapv2.sol";
import "../../interfaces/controller.sol";

import "../strategy-curve-base.sol";

contract StrategyCurveSCRVv3_1 is StrategyCurveBase {
    // Curve stuff
    address public susdv2_pool = 0xA5407eAE9Ba41422680e2e00537571bcC53efBfD;
    address public susdv2_gauge = 0xA90996896660DEcC6E997655E065b23788857849;
    address public scrv = 0xC25a3A3b969415c80451098fa907EC722572917F;

    // Harvesting
    address public snx = 0xC011a73ee8576Fb46F5E1c5751cA3B9Fe0af2a6F;

    constructor(
        address _governance,
        address _strategist,
        address _controller,
        address _timelock
    )
        public
        StrategyCurveBase(
            susdv2_pool,
            susdv2_gauge,
            scrv,
            _governance,
            _strategist,
            _controller,
            _timelock
        )
    {}

    // **** Views ****

    

    

    // **** State Mutations ****

    
}
