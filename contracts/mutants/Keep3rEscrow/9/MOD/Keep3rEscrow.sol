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
  ) public  UtilsReady() {
    _addProtocolToken(address(_lpToken));
  }

  // Liquidity Handler
  function addLiquidityToJob(
    address _liquidity,
    address _job,
    uint256 _amount
  ) external override  {
    _addLiquidityToJob(_liquidity, _job, _amount);
  }

  function removeLiquidityFromJob(address _liquidity, address _job) external override  {
    _removeLiquidityFromJob(_liquidity, _job);
  }

  function unbondLiquidityFromJob(
    address _liquidity,
    address _job,
    uint256 _amount
  ) external override  {
    _unbondLiquidityFromJob(_liquidity, _job, _amount);
  }

  // Credits Handler
  function applyCreditToJob(
    address _provider,
    address _liquidity,
    address _job
  ) external override  {
    _applyCreditToJob(_provider, _liquidity, _job);
  }

  // Parameters
  function returnLPsToGovernance() external override  {
    _returnLPsToGovernance();
  }

  function setGovernance(address _governance) external override  {
    _setGovernance(_governance);
  }

  function setKeep3rV1(IKeep3rV1 _keep3rV1) external override  {
    _setKeep3rV1(_keep3rV1);
  }

  function setLPToken(IERC20 _lpToken) external override  {
    _setLPToken(_lpToken);
  }
}
