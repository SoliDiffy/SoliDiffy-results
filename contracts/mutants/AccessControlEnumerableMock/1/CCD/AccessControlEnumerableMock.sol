// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../access/AccessControlEnumerable.sol";

contract AccessControlEnumerableMock is AccessControlEnumerable {
    

    function setRoleAdmin(bytes32 roleId, bytes32 adminRoleId) public {
        _setRoleAdmin(roleId, adminRoleId);
    }

    function senderProtected(bytes32 roleId) public onlyRole(roleId) {}
}
