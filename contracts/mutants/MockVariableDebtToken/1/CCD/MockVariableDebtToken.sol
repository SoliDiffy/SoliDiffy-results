// SPDX-License-Identifier: agpl-3.0
pragma solidity ^0.6.8;

import {VariableDebtToken} from '../../tokenization/VariableDebtToken.sol';
import {LendingPool} from '../../lendingpool/LendingPool.sol';

contract MockVariableDebtToken is VariableDebtToken {
  

  function getRevision() internal override pure returns (uint256) {
    return 0x2;
  }
}
