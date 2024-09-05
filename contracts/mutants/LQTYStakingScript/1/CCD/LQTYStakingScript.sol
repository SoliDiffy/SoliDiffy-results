// SPDX-License-Identifier: MIT

pragma solidity 0.6.11;

import "../Dependencies/CheckContract.sol";
import "../Interfaces/ILQTYStaking.sol";


contract LQTYStakingScript is CheckContract {
    ILQTYStaking immutable LQTYStaking;

    

    function stake(uint _LQTYamount) external {
        LQTYStaking.stake(_LQTYamount);
    }
}
