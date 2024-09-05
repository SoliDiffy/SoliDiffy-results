// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IAaveDataProvider {
  function getReserveTokensAddresses(address _asset)
    external
    view
    returns (
      address variableDebtTokenAddress,
      address aTokenAddress,
      address stableDebtTokenAddress
    );

  function getUserReserveData(address _asset, address _user)
    external
    view
    returns (
      uint40 stableRateLastUpdated,
      uint256 currentATokenBalance,
      uint256 currentStableDebt,
      uint256 currentVariableDebt,
      uint256 principalStableDebt,
      uint256 scaledVariableDebt,
      uint256 stableBorrowRate,
      uint256 liquidityRate,
      bool usageAsCollateralEnabled
    );

  function getReserveData(address _asset)
    external
    view
    returns (
      uint40 lastUpdateTimestamp,
      uint256 availableLiquidity,
      uint256 totalStableDebt,
      uint256 totalVariableDebt,
      uint256 liquidityRate,
      uint256 variableBorrowRate,
      uint256 stableBorrowRate,
      uint256 averageStableBorrowRate,
      uint256 liquidityIndex,
      uint256 variableBorrowIndex
    );
}
