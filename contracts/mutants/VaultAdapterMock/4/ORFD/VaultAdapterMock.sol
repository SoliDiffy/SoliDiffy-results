// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.6.12;

import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/SafeERC20.sol";

import "../interfaces/IVaultAdapter.sol";

contract VaultAdapterMock is IVaultAdapter {
  using SafeERC20 for IDetailedERC20;

  IDetailedERC20 private _token;

  constructor(IDetailedERC20 token_) public {
    _token = token_;
  }

  

  

  

  
}
