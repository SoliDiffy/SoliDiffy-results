// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "../introspection/ERC1820Implementer.sol";

contract ERC1820ImplementerMock is ERC1820Implementer {
    function registerInterfaceForAddress(bytes32 interfaceHash, address account) external {
        _registerInterfaceForAddress(interfaceHash, account);
    }
}
