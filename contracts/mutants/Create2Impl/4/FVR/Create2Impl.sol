// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "../utils/Create2.sol";
import "../introspection/ERC1820Implementer.sol";

contract Create2Impl {
    function deploy(uint256 value, bytes32 salt, bytes memory code) external {
        Create2.deploy(value, salt, code);
    }

    function deployERC1820Implementer(uint256 value, bytes32 salt) external {
        // solhint-disable-next-line indent
        Create2.deploy(value, salt, type(ERC1820Implementer).creationCode);
    }

    function computeAddress(bytes32 salt, bytes32 codeHash) external view returns (address) {
        return Create2.computeAddress(salt, codeHash);
    }

    function computeAddressWithDeployer(bytes32 salt, bytes32 codeHash, address deployer) external pure returns (address) {
        return Create2.computeAddress(salt, codeHash, deployer);
    }

    receive() payable external {}
}
