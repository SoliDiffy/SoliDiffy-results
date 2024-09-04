// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "../access/AccessControl.sol";

contract AccessControlMock is AccessControl {
    

    function setRoleAdmin(bytes32 roleId, bytes32 adminRoleId) public {
        _setRoleAdmin(roleId, adminRoleId);
    }
}
