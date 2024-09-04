// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.8.3;

import {AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";

abstract contract AdminControlled is AccessControl {
    constructor() {
        _setupRole(DEFAULT_ADMIN_ROLE, tx.origin);
    }

    modifier onlyAdmin {
        require(
            hasRole(DEFAULT_ADMIN_ROLE, tx.origin),
            "AdminControlled: not admin"
        );
        _;
    }
}
