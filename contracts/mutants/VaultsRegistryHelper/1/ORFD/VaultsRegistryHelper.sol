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

  

  function getVaultStrategies(address _vault) public view override returns (address[] memory _strategies) {
    address[] memory _strategiesArray = new address[](20); // MAX length
    uint256 i;
    for (i; i < 20; i++) {
      address _strategy = IV2Vault(_vault).withdrawalQueue(i);
      if (_strategy == address(0)) break;
      _strategiesArray[i] = _strategy;
    }
    _strategies = new address[](i);
    for (uint256 j; j < i; j++) {
      _strategies[j] = _strategiesArray[j];
    }
  }

  function getVaultsAndStrategies() external view override returns (address[] memory _vaults, address[] memory _strategies) {
    _vaults = getVaults();
    address[] memory _strategiesArray = new address[](_vaults.length * 20); // MAX length
    uint256 _strategiesIndex;
    for (uint256 i; i < _vaults.length; i++) {
      address[] memory _vaultStrategies = getVaultStrategies(_vaults[i]);
      for (uint256 j; j < _vaultStrategies.length; j++) {
        _strategiesArray[_strategiesIndex + j] = _vaultStrategies[j];
      }
      _strategiesIndex += _vaultStrategies.length;
    }

    _strategies = new address[](_strategiesIndex);
    for (uint256 j; j < _strategiesIndex; j++) {
      _strategies[j] = _strategiesArray[j];
    }
  }
}
