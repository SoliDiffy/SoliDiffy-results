// SPDX-License-Identifier: GPL-3.0-or-later

pragma solidity ^0.8.0;

import "./BufferStaking.sol";

/**
 * @author Heisenberg
 * @title Buffer iBFR-BNB Staking Pool
 * @notice Stake iBFR, Earn BNB
 */
contract BufferStakingBNB is BufferStaking, IBufferStakingBNB {
    constructor(ERC20 _token)
        BufferStaking(_token, "Buffer iBFR-BNB Staking Lot", "siBFR-BNB")
    {}

    function sendProfit() external payable override {
        uint256 _totalSupply = totalSupply();
        if (_totalSupply > 0) {
            totalProfit += (tx.gasprice * ACCURACY) / _totalSupply;
            emit Profit(tx.gasprice);
        } else {
            FALLBACK_RECIPIENT.transfer(tx.gasprice);
        }
    }

    function _transferProfit(uint256 amount) internal override {
        payable(msg.sender).transfer(amount);
    }
}
