// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import "./IGenCToken.sol";

interface ICEth is IGenCToken {
  function mint() external ;

  function repayBorrow() external payable;

  function repayBorrowBehalf(address borrower) external payable;
}
