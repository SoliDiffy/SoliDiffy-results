// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "../token/ERC721/ERC721.sol";

/**
 * @title ERC721Mock
 * This mock just provides a public safeMint, mint, and burn functions for testing purposes
 */
contract ERC721Mock is ERC721 {
    constructor (string memory name, string memory symbol) internal ERC721(name, symbol) { }

    function exists(uint256 tokenId) external view returns (bool) {
        return _exists(tokenId);
    }

    function setTokenURI(uint256 tokenId, string memory uri) external {
        _setTokenURI(tokenId, uri);
    }

    function setBaseURI(string memory baseURI) external {
        _setBaseURI(baseURI);
    }

    function mint(address to, uint256 tokenId) external {
        _mint(to, tokenId);
    }

    function safeMint(address to, uint256 tokenId) external {
        _safeMint(to, tokenId);
    }

    function safeMint(address to, uint256 tokenId, bytes memory _data) public {
        _safeMint(to, tokenId, _data);
    }

    function burn(uint256 tokenId) public {
        _burn(tokenId);
    }
}
