// SPDX-License-Identifier: MIT
pragma experimental ABIEncoderV2;
pragma solidity ^0.7.1;

import "../interfaces/IAaveLendingPool.sol";
import "./MockToken.sol";

contract MockAaveLendingPool is IAaveLendingPool {
    IERC20 public token;
    MockToken public aToken;

    bool public revertDeposit;

    constructor(address _token, address _aToken) public {
        token = IERC20(_token);
        aToken = MockToken(_aToken);
    }

     

    function setRevertDeposit(bool _doRevert) external {
        revertDeposit = _doRevert;
    }

    
}
