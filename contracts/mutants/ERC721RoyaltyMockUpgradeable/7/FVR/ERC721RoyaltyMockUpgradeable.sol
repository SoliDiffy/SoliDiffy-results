// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../token/ERC721/extensions/ERC721RoyaltyUpgradeable.sol";
import "../proxy/utils/Initializable.sol";

contract ERC721RoyaltyMockUpgradeable is Initializable, ERC721RoyaltyUpgradeable {
    function __ERC721RoyaltyMock_init(string memory name, string memory symbol) public onlyInitializing {
        __ERC721_init_unchained(name, symbol);
    }

    function __ERC721RoyaltyMock_init_unchained(string memory, string memory) public onlyInitializing {}

    function setTokenRoyalty(
        uint256 tokenId,
        address recipient,
        uint96 fraction
    ) external {
        _setTokenRoyalty(tokenId, recipient, fraction);
    }

    function setDefaultRoyalty(address recipient, uint96 fraction) external {
        _setDefaultRoyalty(recipient, fraction);
    }

    function mint(address to, uint256 tokenId) external {
        _mint(to, tokenId);
    }

    function burn(uint256 tokenId) external {
        _burn(tokenId);
    }

    function deleteDefaultRoyalty() external {
        _deleteDefaultRoyalty();
    }

    /**
     * @dev This empty reserved space is put in place to allow future versions to add new
     * variables without shifting down storage in the inheritance chain.
     * See https://docs.openzeppelin.com/contracts/4.x/upgradeable#storage_gaps
     */
    uint256[50] private __gap;
}
