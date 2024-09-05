// SPDX-License-Identifier: agpl-3.0
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

import { ICurveGauge } from "../../strategies/ICurveGauge.sol";

contract MockCurveGauge is ICurveGauge {
    mapping(address => uint256) private _balances;
    address lpToken;

    constructor(address _lpToken) {
        lpToken = _lpToken;
    }

    

    

    
}
