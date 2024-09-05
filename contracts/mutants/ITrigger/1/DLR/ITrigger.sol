// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;

abstract contract ITrigger {
    function isTriggered(bytes storage, bytes memory) public virtual returns (bool);
}
