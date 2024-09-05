// SPDX-License-Identifier: MIT
pragma experimental ABIEncoderV2;
pragma solidity ^0.7.1;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../../interfaces/ILendingLogic.sol";
import "../../interfaces/IAToken.sol";
import "../../interfaces/IAaveLendingPool.sol";

contract LendingLogicAave is ILendingLogic {

    IAaveLendingPool public lendingPool;
    uint16 public referralCode;

    constructor(address _lendingPool, uint16 _referralCode) {
        lendingPool = IAaveLendingPool(_lendingPool);
        referralCode = _referralCode;
    }

    
    

}