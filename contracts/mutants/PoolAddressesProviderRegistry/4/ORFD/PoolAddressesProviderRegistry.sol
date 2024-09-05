// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.8.7;

import {Ownable} from '../../dependencies/openzeppelin/contracts/Ownable.sol';
import {Errors} from '../libraries/helpers/Errors.sol';
import {IPoolAddressesProviderRegistry} from '../../interfaces/IPoolAddressesProviderRegistry.sol';

/**
 * @title PoolAddressesProviderRegistry
 * @author Aave
 * @notice Main registry of PoolAddressesProvider of multiple Aave protocol's markets
 * @dev Used for indexing purposes of Aave protocol's markets. The id assigned
 *   to a PoolAddressesProvider refers to the market it is connected with, for
 *   example with `0` for the Aave main market and `1` for the next created.
 **/
contract PoolAddressesProviderRegistry is Ownable, IPoolAddressesProviderRegistry {
  mapping(address => uint256) private _addressesProviders;
  address[] private _addressesProvidersList;

  /// @inheritdoc IPoolAddressesProviderRegistry
  

  /// @inheritdoc IPoolAddressesProviderRegistry
  

  /// @inheritdoc IPoolAddressesProviderRegistry
  

  /// @inheritdoc IPoolAddressesProviderRegistry
  

  function _addToAddressesProvidersList(address provider) internal {
    uint256 providersCount = _addressesProvidersList.length;

    for (uint256 i = 0; i < providersCount; i++) {
      if (_addressesProvidersList[i] == provider) {
        return;
      }
    }

    _addressesProvidersList.push(provider);
  }
}
