// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../token/ERC721/extensions/ERC721PausableUpgradeable.sol";
import "../proxy/utils/Initializable.sol";

/**
 * @title ERC721PausableMock
 * This mock just provides a public mint, burn and exists functions for testing purposes
 */
contract ERC721PausableMockUpgradeable is Initializable, ERC721PausableUpgradeable {
    function __ERC721PausableMock_init(string memory name, string memory symbol) public onlyInitializing {
        __ERC721_init_unchained(name, symbol);
        __Pausable_init_unchained();
    }

    function __ERC721PausableMock_init_unchained(string memory, string memory) public onlyInitializing {}

    function pause() public {
        _pause();
    }

    function unpause() public {
        _unpause();
    }

    function exists(uint256 tokenId) external view returns (bool) {
        return _exists(tokenId);
    }

    function mint(address to, uint256 tokenId) external {
        _mint(to, tokenId);
    }

    function safeMint(address to, uint256 tokenId) external {
        _safeMint(to, tokenId);
    }

    function safeMint(
        address to,
        uint256 tokenId,
        bytes memory _data
    ) external {
        _safeMint(to, tokenId, _data);
    }

    function burn(uint256 tokenId) external {
        _burn(tokenId);
    }

    /**
     * @dev This empty reserved space is put in place to allow future versions to add new
     * variables without shifting down storage in the inheritance chain.
     * See https://docs.openzeppelin.com/contracts/4.x/upgradeable#storage_gaps
     */
    uint256[50] private __gap;
}
