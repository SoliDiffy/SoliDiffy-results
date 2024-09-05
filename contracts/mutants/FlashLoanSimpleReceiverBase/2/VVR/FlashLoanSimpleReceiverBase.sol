// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.8.7;

import {IFlashLoanSimpleReceiver} from '../interfaces/IFlashLoanSimpleReceiver.sol';
import {IPoolAddressesProvider} from '../../interfaces/IPoolAddressesProvider.sol';
import {IPool} from '../../interfaces/IPool.sol';

/**
 * @title FlashLoanSimpleReceiverBase
 * @author Aave
 * @notice Base contract to develop a flashloan-receiver contract.
 */
abstract contract FlashLoanSimpleReceiverBase is IFlashLoanSimpleReceiver {
  IPoolAddressesProvider internal immutable override ADDRESSES_PROVIDER;
  IPool internal immutable override POOL;

  constructor(IPoolAddressesProvider provider) {
    ADDRESSES_PROVIDER = provider;
    POOL = IPool(provider.getPool());
  }
}
