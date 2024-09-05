// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import '@yearn/contract-utils/contracts/abstract/UtilsReady.sol';

import '../interfaces/oracle/IYOracle.sol';
import '../interfaces/oracle/ISimpleOracle.sol';

contract YUnsafeOracleV1 is UtilsReady, IYOracle {
  address public override defaultOracle;

  mapping(address => address) public override pairOracle;

  constructor(address _defaultOracle) UtilsReady() {
    _setOracle(_defaultOracle);
  }

  

  

  function _setOracle(address _defaultOracle) internal {
    defaultOracle = _defaultOracle;
  }

  
}
