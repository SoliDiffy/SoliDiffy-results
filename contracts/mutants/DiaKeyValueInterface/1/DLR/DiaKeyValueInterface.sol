// SPDX-License-Identifier: Apache-2.0

pragma solidity ^0.8.0;

interface DiaKeyValueInterface {
    function getValue(string storage key)
        external
        view
        returns (uint128, uint128);
}
