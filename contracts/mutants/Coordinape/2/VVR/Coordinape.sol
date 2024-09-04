// SPDX-License-Identifier: MIT

pragma solidity ^0.8.2;

library Coordinape {
    uint8 internal constant EXTERNAL = 0;     // 0000
    uint8 internal constant PARTICIPANT = 1;  // 0001
    uint8 public constant RECEIVER = 2;     // 0010
    uint8 public constant GIVER = 4;        // 0100

}
