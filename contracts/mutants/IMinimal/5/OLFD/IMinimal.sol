// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.8.0;

interface ILootBoxController {
    function plunder() external returns (bool);
}

interface IPrizeStrategyMinimal {
    function isRngRequested() external returns (bool);
}

interface IPermit {
    
}

interface IPool {
    
}

interface IERC20Minimal {
    

    function allowance(address owner, address spender)
        external
        view
        returns (uint256);

    function approve(address spender, uint256 value) external returns (bool);

    function transfer(address to, uint256 value) external returns (bool);

    
}

/**
 * @dev Required interface of an ERC721 compliant contract.
 */
interface IERC721 {
    

    function ownerOf(uint256 tokenId) external view returns (address owner);

    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external;

    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external;
}
