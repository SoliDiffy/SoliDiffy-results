// SPDX-License-Identifier: agpl-3.0
pragma solidity ^0.6.8;

import {SafeMath} from '@openzeppelin/contracts/math/SafeMath.sol';
import {IERC20} from '@openzeppelin/contracts/token/ERC20/IERC20.sol';

import {FlashLoanReceiverBase} from '../../flashloan/base/FlashLoanReceiverBase.sol';
import {MintableERC20} from '../tokens/MintableERC20.sol';
import {SafeERC20} from '@openzeppelin/contracts/token/ERC20/SafeERC20.sol';
import {ILendingPoolAddressesProvider} from '../../interfaces/ILendingPoolAddressesProvider.sol';

contract MockFlashLoanReceiver is FlashLoanReceiverBase {
  using SafeMath for uint256;
  using SafeERC20 for IERC20;

  ILendingPoolAddressesProvider internal _provider;

  event ExecutedWithFail(address _reserve, uint256 _amount, uint256 _fee);
  event ExecutedWithSuccess(address _reserve, uint256 _amount, uint256 _fee);

  bool _failExecution;
  uint256 _amountToApprove;

  constructor(ILendingPoolAddressesProvider provider) public FlashLoanReceiverBase(provider) {}

  function setFailExecutionTransfer(bool fail) public {
    _failExecution = fail;
  }

  function setAmountToApprove(uint256 amountToApprove) public {
    _amountToApprove = amountToApprove;
  }

  function amountToApprove() public view returns (uint256) {
    return _amountToApprove;
  }

  
}
