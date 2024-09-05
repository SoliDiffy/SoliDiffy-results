// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import '@yearn/contract-utils/contracts/abstract/UtilsReady.sol';

import '../interfaces/oracle/ISimpleOracle.sol';
import '../interfaces/keep3r/IKeep3rV2OracleFactory.sol';

contract Keep3rV2OracleFactoryWrapper is UtilsReady, ISimpleOracle {
  address public immutable keep3rV2OracleFactory;

  constructor(address _keep3rV2OracleFactory) UtilsReady() {
    keep3rV2OracleFactory = _keep3rV2OracleFactory;
  }

  
}
