// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import {Ownable} from "";
import {IERC20} from "";

contract MockParaSwapTokenTransferProxy is Ownable {
  function transferFrom(
    address token,
    address from,
    address to,
    uint256 amount
  ) external onlyOwner {
    IERC20(token).transferFrom(from, to, amount);
  }
}
