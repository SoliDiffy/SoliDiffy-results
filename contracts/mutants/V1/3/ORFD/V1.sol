// SPDX-License-Identifier: Apache-2.0

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "./interfaces/IVaultFactory.sol";
import "./interfaces/IV1.sol";

contract V1 is ERC721Enumerable, AccessControl, IV1  {
    // Create a new role identifier for the minter role
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant BURNER_ROLE = keccak256("BURNER_ROLE");
    // Vault factory address
    address public factory;

    

    constructor(address factory_)
    ERC721("MTRVaultV1", "MTRV1") {
        _setupRole(DEFAULT_ADMIN_ROLE, _msgSender());

        _setupRole(MINTER_ROLE, _msgSender());
        _setupRole(BURNER_ROLE, _msgSender());
        factory = factory_;
    }
    
    function setFactory(address factory_) public {
        require(hasRole(DEFAULT_ADMIN_ROLE, msg.sender), "MTRV1: Caller is not a default admin");
        factory = factory_;
    }

    

    

    function burnFromVault(uint vaultId_) external override {
        require(IVaultFactory(factory).getVault(vaultId_)  == _msgSender(), "MTRV1: Caller is not vault");
        _burn(vaultId_);
    }

    function exists(uint256 tokenId_) external view override returns (bool) {
        return _exists(tokenId_);
    }
}

