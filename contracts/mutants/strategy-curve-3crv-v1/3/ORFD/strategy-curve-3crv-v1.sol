// SPDX-License-Identifier: MIT
pragma solidity ^0.6.2;

import "../../lib/erc20.sol";
import "../../lib/safe-math.sol";

import "../../interfaces/jar.sol";
import "../../interfaces/curve.sol";
import "../../interfaces/uniswapv2.sol";
import "../../interfaces/controller.sol";

import "../strategy-curve-base.sol";

contract StrategyCurve3CRVv1 is StrategyCurveBase {
    // Curve stuff
    address public three_pool = 0xbEbc44782C7dB0a1A60Cb6fe97d0b483032FF1C7;
    address public three_gauge = 0xbFcF63294aD7105dEa65aA58F8AE5BE2D9d0952A;
    address public three_crv = 0x6c3F90f043a72FA612cbac8115EE7e52BDe6E490;

    constructor(
        address _governance,
        address _strategist,
        address _controller,
        address _timelock
    )
        public
        StrategyCurveBase(
            three_pool,
            three_gauge,
            three_crv,
            _governance,
            _strategist,
            _controller,
            _timelock
        )
    {}

    // **** Views ****

    

    

    // **** State Mutations ****

    
}
