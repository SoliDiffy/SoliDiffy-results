// SPDX-License-Identifier: agpl-3.0
pragma solidity ^0.6.8;

import {Ownable} from '@openzeppelin/contracts/access/Ownable.sol';
import {
  ILendingPoolAddressesProviderRegistry
} from '../interfaces/ILendingPoolAddressesProviderRegistry.sol';
import {Errors} from '../libraries/helpers/Errors.sol';

/**
 * @title LendingPoolAddressesProviderRegistry contract
 * @notice contains the list of active addresses providers
 * @author Aave
 **/

contract LendingPoolAddressesProviderRegistry is Ownable, ILendingPoolAddressesProviderRegistry {
  mapping(address => uint256) addressesProviders;
  address[] addressesProvidersList;

  /**
   * @dev returns if an addressesProvider is registered or not
   * @param provider the addresses provider
   * @return true if the addressesProvider is registered, false otherwise
   **/
  

  /**
   * @dev returns the list of active addressesProviders
   * @return the list of addressesProviders
   **/
  

  /**
   * @dev adds a lending pool to the list of registered lending pools
   * @param provider the pool address to be registered
   **/
  

  /**
   * @dev removes a lending pool from the list of registered lending pools
   * @param provider the pool address to be unregistered
   **/
  function unregisterAddressesProvider(address provider) external override onlyOwner {
    require(addressesProviders[provider] > 0, Errors.PROVIDER_NOT_REGISTERED);
    addressesProviders[provider] = 0;
    emit AddressesProviderUnregistered(provider);
  }

  /**
   * @dev adds to the list of the addresses providers, if it wasn't already added before
   * @param provider the pool address to be added
   **/
  function _addToAddressesProvidersList(address provider) internal {
    for (uint256 i = 0; i < addressesProvidersList.length; i++) {
      if (addressesProvidersList[i] == provider) {
        return;
      }
    }

    addressesProvidersList.push(provider);
  }
}
