pragma solidity ^0.5.0;

import "../access/roles/WhitelistedRole.sol";

contract WhitelistedRoleMock is WhitelistedRole {
    function onlyWhitelistedMock() external view onlyWhitelisted {
        // solhint-disable-previous-line no-empty-blocks
    }
}
