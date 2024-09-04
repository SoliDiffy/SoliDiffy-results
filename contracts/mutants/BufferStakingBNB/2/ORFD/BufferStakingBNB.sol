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

    

    
}
