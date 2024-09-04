// SPDX-License-Identifier: MIT

pragma solidity 0.6.11;

import "../DefaultPool.sol";

contract DefaultPoolTester is DefaultPool {
    
    function unprotectedIncreaseLUSDDebt(uint _amount) public {
        LUSDDebt  = LUSDDebt.add(_amount);
    }

    function unprotectedPayable() public payable {
        ETH = ETH.add(msg.value);
    }
}
