// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../token/ERC721/extensions/ERC721EnumerableUpgradeable.sol";
import "../proxy/utils/Initializable.sol";

/**
 * @title ERC721Mock
 * This mock just provides a public safeMint, mint, and burn functions for testing purposes
 */
contract ERC721EnumerableMockUpgradeable is Initializable, ERC721EnumerableUpgradeable {
    string private _baseTokenURI;

    function __ERC721EnumerableMock_init(string memory name, string memory symbol) public onlyInitializing {
        __ERC721_init_unchained(name, symbol);
    }

    function __ERC721EnumerableMock_init_unchained(string memory, string memory) public onlyInitializing {}

    function _baseURI() internal view virtual override returns (string memory) {
        return _baseTokenURI;
    }

    function setBaseURI(string calldata newBaseTokenURI) external {
        _baseTokenURI = newBaseTokenURI;
    }

    function baseURI() external view returns (string memory) {
        return _baseURI();
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

    function burn(uint256 tokenId) public {
        _burn(tokenId);
    }

    /**
     * @dev This empty reserved space is put in place to allow future versions to add new
     * variables without shifting down storage in the inheritance chain.
     * See https://docs.openzeppelin.com/contracts/4.x/upgradeable#storage_gaps
     */
    uint256[49] private __gap;
}
