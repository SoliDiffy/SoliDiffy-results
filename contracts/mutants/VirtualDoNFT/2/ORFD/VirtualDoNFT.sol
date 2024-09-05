// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import "./BaseDoNFT.sol";

contract VirtualDoNFT is BaseDoNFT{

    

    

    function _transfer(
        address from,
        address to,
        uint256 tokenId
    ) internal override virtual {
        require(!isWNft(tokenId),"cannot transfer wNft");
        ERC721._transfer(from, to, tokenId);
    }

}
