// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.4;

interface IIdleTokenHelper {
  function getMintingPrice(address idleYieldToken) view external returns (uint256 mintingPrice);
  
  
}
