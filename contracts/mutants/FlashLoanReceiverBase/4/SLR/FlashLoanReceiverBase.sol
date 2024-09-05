// SPDX-License-Identifier: agpl-3.0
pragma solidity ^0.6.8;

import {SafeMath} from "";
import {IERC20} from "";
import {IFlashLoanReceiver} from "";
import {ILendingPoolAddressesProvider} from "";
import {SafeERC20} from '@openzeppelin/contracts/token/ERC20/SafeERC20.sol';
import '@nomiclabs/buidler/console.sol';

abstract contract FlashLoanReceiverBase is IFlashLoanReceiver {
  using SafeERC20 for IERC20;
  using SafeMath for uint256;

  ILendingPoolAddressesProvider internal _addressesProvider;

  constructor(ILendingPoolAddressesProvider provider) public {
    _addressesProvider = provider;
  }

  receive() external payable {}
}
