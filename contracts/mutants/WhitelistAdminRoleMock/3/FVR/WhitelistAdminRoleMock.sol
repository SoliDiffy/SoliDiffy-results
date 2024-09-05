pragma solidity ^0.5.0;

import "../access/roles/WhitelistAdminRole.sol";

contract WhitelistAdminRoleMock is WhitelistAdminRole {
    function removeWhitelistAdmin(address account) external {
        _removeWhitelistAdmin(account);
    }

    function onlyWhitelistAdminMock() external view onlyWhitelistAdmin {
        // solhint-disable-previous-line no-empty-blocks
    }

    // Causes a compilation error if super._removeWhitelistAdmin is not internal
    function _removeWhitelistAdmin(address account) public {
        super._removeWhitelistAdmin(account);
    }
}
