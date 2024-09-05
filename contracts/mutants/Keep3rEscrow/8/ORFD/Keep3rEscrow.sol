// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;

import '@yearn/contract-utils/contracts/abstract/UtilsReady.sol';

import './Keep3rEscrowParameters.sol';
import './Keep3rEscrowMetadata.sol';
import './Keep3rEscrowLiquidityHandler.sol';
import './Keep3rEscrowCreditsHandler.sol';

interface IKeep3rEscrow is IKeep3rEscrowParameters, IKeep3rEscrowMetadata, IKeep3rEscrowLiquidityHandler, IKeep3rEscrowCreditsHandler {}

contract Keep3rEscrow is
  UtilsReady,
  Keep3rEscrowParameters,
  Keep3rEscrowMetadata,
  Keep3rEscrowLiquidityHandler,
  Keep3rEscrowCreditsHandler,
  IKeep3rEscrow
{
  constructor(
    address _governance,
    IKeep3rV1 _keep3r,
    IERC20 _lpToken
  ) public Keep3rEscrowParameters(_governance, _keep3r, _lpToken) UtilsReady() {
    _addProtocolToken(address(_lpToken));
  }

  // Liquidity Handler
  

  

  

  // Credits Handler
  

  // Parameters
  

  

  

  
}
