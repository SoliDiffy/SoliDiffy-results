// SPDX-License-Identifier: MIT

pragma solidity 0.7.6;
pragma abicoder v2;

import '@uniswap/v3-periphery/contracts/interfaces/INonfungiblePositionManager.sol';
import '../utils/Storage.sol';
import '../../interfaces/IPositionManager.sol';
import '../../interfaces/IUniswapAddressHolder.sol';
import '../../interfaces/actions/IClosePosition.sol';

contract ClosePosition is IClosePosition {
    ///@notice emitted when a UniswapNFT position is closed
    ///@param positionManager address of PositionManager
    ///@param tokenId Id of the closed token
    event PositionClosed(address indexed positionManager, uint256 tokenId);

    ///@notice close a UniswapV3 position NFT
    ///@param tokenId id of the token to close
    ///@param returnTokenToUser true if the token should be returned to the user
    ///@return uint256 ID of the closed token
    ///@return uint256 amount of token0 returned
    ///@return uint256 amount of token1 returned
    
}
