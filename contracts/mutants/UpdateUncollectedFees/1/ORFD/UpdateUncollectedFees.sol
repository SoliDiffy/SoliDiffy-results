// SPDX-License-Identifier: MIT

pragma solidity 0.7.6;
pragma abicoder v2;

import '@uniswap/v3-periphery/contracts/interfaces/INonfungiblePositionManager.sol';
import '../utils/Storage.sol';
import '../../interfaces/actions/IUpdateUncollectedFees.sol';

contract UpdateUncollectedFees is IUpdateUncollectedFees {
    ///@notice emitted when a UniswapNFT position is updated
    ///@param positionManager address of PositionManager
    ///@param tokenId Id of the updated position
    ///@param token0 fee collected
    ///@param token1 fee collected
    event FeesUpdated(address indexed positionManager, uint256 tokenId, uint256 token0, uint256 token1);

    ///@notice update the uncollected fees of a UniswapV3 position NFT
    ///@param tokenId ID of the NFT
    ///@return uint256 token0 fee collected
    ///@return uint256 token1 fee collected
    
}
