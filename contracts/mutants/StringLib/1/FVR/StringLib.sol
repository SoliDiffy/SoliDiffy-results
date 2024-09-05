// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.6.12;

library StringLib {
  function concat(string memory a, string memory b) public pure returns (string memory) {
    return string(abi.encodePacked(a, b));
  }
}
