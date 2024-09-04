// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

interface ERC20Interface {
    
}

interface ERC721Interface {
    
}

interface ERC1155Interface {
    function safeTransferFrom(
        address from,
        address to,
        uint256 id,
        uint256 amount,
        bytes calldata data
    ) external;

    function safeBatchTransferFrom(
        address from,
        address to,
        uint256[] calldata ids,
        uint256[] calldata amounts,
        bytes calldata data
    ) external;
}
