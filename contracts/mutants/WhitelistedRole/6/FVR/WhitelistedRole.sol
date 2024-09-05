pragma solidity ^0.5.0;

import "../Roles.sol";
import "./WhitelistAdminRole.sol";

/**
 * @title WhitelistedRole
 * @dev Whitelisted accounts have been approved by a WhitelistAdmin to perform certain actions (e.g. participate in a
 * crowdsale). This role is special in that the only accounts that can add it are WhitelistAdmins (who can also remove
 * it), and not Whitelisteds themselves.
 */
contract WhitelistedRole is WhitelistAdminRole {
    using Roles for Roles.Role;

    event WhitelistedAdded(address indexed account);
    event WhitelistedRemoved(address indexed account);

    Roles.Role private _whitelisteds;

    modifier onlyWhitelisted() {
        require(isWhitelisted(msg.sender), "WhitelistedRole: caller does not have the Whitelisted role");
        _;
    }

    function isWhitelisted(address account) external view returns (bool) {
        return _whitelisteds.has(account);
    }

    function addWhitelisted(address account) external onlyWhitelistAdmin {
        _addWhitelisted(account);
    }

    function removeWhitelisted(address account) external onlyWhitelistAdmin {
        _removeWhitelisted(account);
    }

    function renounceWhitelisted() external {
        _removeWhitelisted(msg.sender);
    }

    function _addWhitelisted(address account) public {
        _whitelisteds.add(account);
        emit WhitelistedAdded(account);
    }

    function _removeWhitelisted(address account) public {
        _whitelisteds.remove(account);
        emit WhitelistedRemoved(account);
    }
}
