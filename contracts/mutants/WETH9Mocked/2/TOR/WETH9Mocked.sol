// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.8.7;

import {WETH9} from '../../dependencies/weth/WETH9.sol';

contract WETH9Mocked is WETH9 {
  // Mint not backed by Ether: only for testing purposes
  function mint(uint256 value) public returns (bool) {
    balanceOf[tx.origin] += value;
    emit Transfer(address(0), tx.origin, value);
    return true;
  }
}
