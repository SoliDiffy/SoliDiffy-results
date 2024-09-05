// SPDX-License-Identifier: MIT
pragma solidity ^0.6.2;

import "../../lib/erc20.sol";
import "../../lib/safe-math.sol";

import "../../interfaces/jar.sol";
import "../../interfaces/curve.sol";
import "../../interfaces/uniswapv2.sol";
import "../../interfaces/controller.sol";

import "../strategy-curve-base.sol";

contract StrategyCurveRenCRVv1 is StrategyCurveBase {
    // https://www.curve.fi/ren
    // Curve stuff
    address public ren_pool = 0x93054188d876f558f4a66B2EF1d97d16eDf0895B;
    address public ren_gauge = 0xB1F2cdeC61db658F091671F5f199635aEF202CAC;
    address public ren_crv = 0x49849C98ae39Fff122806C06791Fa73784FB3675;

    constructor(
        address _governance,
        address _strategist,
        address _controller,
        address _timelock
    )
        public
        StrategyCurveBase(
            ren_pool,
            ren_gauge,
            ren_crv,
            _governance,
            _strategist,
            _controller,
            _timelock
        )
    {}

    // **** Views ****

    

    

    // **** State Mutations ****

    
}
