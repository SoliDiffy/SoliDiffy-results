// SPDX-License-Identifier: MIT

pragma solidity 0.7.6;
pragma abicoder v2;

import '@uniswap/v3-periphery/contracts/interfaces/INonfungiblePositionManager.sol';
import '../helpers/ERC20Helper.sol';
import '../utils/Storage.sol';
import '../../interfaces/IPositionManager.sol';
import '../../interfaces/actions/IMint.sol';

///@notice action to mint a UniswapV3 position NFT
contract Mint is IMint {
    ///@notice emitted when a UniswapNFT is deposited in PositionManager
    ///@param positionManager address of PositionManager
    ///@param tokenId Id of deposited token
    event PositionMinted(address indexed positionManager, uint256 tokenId);

    ///@notice mints a UniswapV3 position NFT
    ///@param inputs struct of MintInput parameters
    ///@return tokenId ID of the minted NFT
    ///@return amount0Deposited token0 amount deposited
    ///@return amount1Deposited token1 amount deposited
    
}
