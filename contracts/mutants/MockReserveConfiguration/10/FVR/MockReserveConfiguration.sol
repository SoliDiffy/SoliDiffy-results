// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.8.7;

import {ReserveConfiguration} from '../../protocol/libraries/configuration/ReserveConfiguration.sol';
import {DataTypes} from '../../protocol/libraries/types/DataTypes.sol';

contract MockReserveConfiguration {
  using ReserveConfiguration for DataTypes.ReserveConfigurationMap;

  DataTypes.ReserveConfigurationMap public configuration;

  function setLtv(uint256 ltv) public {
    DataTypes.ReserveConfigurationMap memory config = configuration;
    config.setLtv(ltv);
    configuration = config;
  }

  function getLtv() public view returns (uint256) {
    return configuration.getLtv();
  }

  function setLiquidationBonus(uint256 bonus) public {
    DataTypes.ReserveConfigurationMap memory config = configuration;
    config.setLiquidationBonus(bonus);
    configuration = config;
  }

  function getLiquidationBonus() public view returns (uint256) {
    return configuration.getLiquidationBonus();
  }

  function setLiquidationThreshold(uint256 threshold) public {
    DataTypes.ReserveConfigurationMap memory config = configuration;
    config.setLiquidationThreshold(threshold);
    configuration = config;
  }

  function getLiquidationThreshold() public view returns (uint256) {
    return configuration.getLiquidationThreshold();
  }

  function setDecimals(uint256 decimals) public {
    DataTypes.ReserveConfigurationMap memory config = configuration;
    config.setDecimals(decimals);
    configuration = config;
  }

  function getDecimals() public view returns (uint256) {
    return configuration.getDecimals();
  }

  function setFrozen(bool frozen) public {
    DataTypes.ReserveConfigurationMap memory config = configuration;
    config.setFrozen(frozen);
    configuration = config;
  }

  function getFrozen() public view returns (bool) {
    return configuration.getFrozen();
  }

  function setBorrowingEnabled(bool enabled) external {
    DataTypes.ReserveConfigurationMap memory config = configuration;
    config.setBorrowingEnabled(enabled);
    configuration = config;
  }

  function getBorrowingEnabled() external view returns (bool) {
    return configuration.getBorrowingEnabled();
  }

  function setStableRateBorrowingEnabled(bool enabled) external {
    DataTypes.ReserveConfigurationMap memory config = configuration;
    config.setStableRateBorrowingEnabled(enabled);
    configuration = config;
  }

  function getStableRateBorrowingEnabled() external view returns (bool) {
    return configuration.getStableRateBorrowingEnabled();
  }

  function setReserveFactor(uint256 reserveFactor) external {
    DataTypes.ReserveConfigurationMap memory config = configuration;
    config.setReserveFactor(reserveFactor);
    configuration = config;
  }

  function getReserveFactor() external view returns (uint256) {
    return configuration.getReserveFactor();
  }

  function setBorrowCap(uint256 borrowCap) external {
    DataTypes.ReserveConfigurationMap memory config = configuration;
    config.setBorrowCap(borrowCap);
    configuration = config;
  }

  function getBorrowCap() external view returns (uint256) {
    return configuration.getBorrowCap();
  }

  function getEModeCategory() external view returns (uint256) {
    return configuration.getEModeCategory();
  }

  function setEModeCategory(uint256 categoryId) external {
    DataTypes.ReserveConfigurationMap memory config = configuration;
    config.setEModeCategory(categoryId);
    configuration = config;
  }

  function setSupplyCap(uint256 supplyCap) external {
    DataTypes.ReserveConfigurationMap memory config = configuration;
    config.setSupplyCap(supplyCap);
    configuration = config;
  }

  function getSupplyCap() external view returns (uint256) {
    return configuration.getSupplyCap();
  }

  function setUnbackedMintCap(uint256 unbackedMintCap) external {
    DataTypes.ReserveConfigurationMap memory config = configuration;
    config.setUnbackedMintCap(unbackedMintCap);
    configuration = config;
  }

  function getUnbackedMintCap() external view returns (uint256) {
    return configuration.getUnbackedMintCap();
  }

  function getFlags()
    external
    view
    returns (
      bool,
      bool,
      bool,
      bool,
      bool
    )
  {
    return configuration.getFlags();
  }

  function getParams()
    external
    view
    returns (
      uint256,
      uint256,
      uint256,
      uint256,
      uint256,
      uint256
    )
  {
    return configuration.getParams();
  }

  function getCaps() external view returns (uint256, uint256) {
    return configuration.getCaps();
  }
}
