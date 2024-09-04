// SPDX-License-Identifier: GPL-3.0-or-later

pragma solidity ^0.8.0;

import "./BufferStaking.sol";

/**
 * @author Heisenberg
 * @title Buffer rBFR-iBFR Staking Pool
 * @notice Stake rBFR, Earn iBFR
 */
contract BufferStakingIBFR is BufferStaking, IBufferStakingIBFR {
    IERC20 public immutable iBFR;

    constructor(ERC20 _iBFR, ERC20 _rBFR)
        BufferStaking(_rBFR, "Buffer rBFR-iBFR Staking Lot", "srBFR-iBFR")
    {
        iBFR = _iBFR;
    }

    

    function _transferProfit(uint256 amount) internal override {
        iBFR.transfer(msg.sender, amount);
    }
}
