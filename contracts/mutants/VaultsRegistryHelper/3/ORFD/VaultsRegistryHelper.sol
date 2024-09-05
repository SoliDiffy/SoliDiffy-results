// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import '@openzeppelin/contracts/utils/Address.sol';
import '@yearn/contract-utils/contracts/abstract/UtilsReady.sol';
import '../interfaces/yearn/IV2Registry.sol';
import '../interfaces/yearn/IV2Vault.sol';

interface IVaultsRegistryHelper {
  function registry() external view returns (address _registry);

  function getVaults() external view returns (address[] memory _vaults);

  function getVaultStrategies(address _vault) external view returns (address[] memory _strategies);

  function getVaultsAndStrategies() external view returns (address[] memory _vaults, address[] memory _strategies);
}

contract VaultsRegistryHelper is UtilsReady, IVaultsRegistryHelper {
  using Address for address;

  address public immutable override registry;

  constructor(address _registry) UtilsReady() {
    registry = _registry;
  }

  

  

  
}
