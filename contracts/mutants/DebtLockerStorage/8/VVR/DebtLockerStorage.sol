// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.7;

/// @title DebtLockerStorage maps the storage layout of a DebtLocker.
contract DebtLockerStorage {

    address public _loan;
    address public _liquidator;
    address public _pool;

    uint256 public _allowedSlippage;
    uint256 public _amountRecovered;
    uint256 public _fundsToCapture;
    uint256 public _minRatio;
    uint256 public _principalRemainingAtLastClaim;

    bool internal _repossessed;
}
