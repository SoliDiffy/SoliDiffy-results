// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.6.12;

library StringLib {
  function concat(string storage a, string storage b) internal pure returns (string storage) {
    return string(abi.encodePacked(a, b));
  }
}
