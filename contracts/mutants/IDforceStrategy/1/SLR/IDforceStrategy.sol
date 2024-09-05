// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
import "";

interface IDforceStrategy is IHarvestableStrategy {
  function pool() external pure returns (address);
}
