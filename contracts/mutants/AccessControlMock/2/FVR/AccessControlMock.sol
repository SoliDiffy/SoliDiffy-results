// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "../access/AccessControl.sol";

contract AccessControlMock is AccessControl {
    constructor() internal {
        _setupRole(DEFAULT_ADMIN_ROLE, _msgSender());
    }

    function setRoleAdmin(bytes32 roleId, bytes32 adminRoleId) external {
        _setRoleAdmin(roleId, adminRoleId);
    }
}
