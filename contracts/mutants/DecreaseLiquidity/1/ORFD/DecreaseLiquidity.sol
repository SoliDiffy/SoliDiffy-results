// SPDX-License-Identifier: MIT

pragma solidity 0.7.6;
pragma abicoder v2;

import '@uniswap/v3-core/contracts/libraries/TickMath.sol';
import '@uniswap/v3-core/contracts/interfaces/IUniswapV3Pool.sol';
import '@uniswap/v3-periphery/contracts/libraries/LiquidityAmounts.sol';
import '@uniswap/v3-periphery/contracts/interfaces/INonfungiblePositionManager.sol';
import '../helpers/UniswapNFTHelper.sol';
import '../utils/Storage.sol';
import '../../interfaces/actions/IDecreaseLiquidity.sol';

///@notice action to decrease liquidity of an NFT position
contract DecreaseLiquidity is IDecreaseLiquidity {
    ///@notice emitted when liquidity is decreased
    ///@param positionManager address of the position manager which decreased liquidity
    ///@param tokenId id of the position
    event LiquidityDecreased(address indexed positionManager, uint256 tokenId);

    ///@notice decrease the liquidity of a V3 position
    ///@param tokenId the tokenId of the position
    ///@param amount0Desired the amount of token0 liquidity desired
    ///@param amount1Desired the amount of token1 liquidity desired
    ///@return liquidityToDecrease the amount of liquidity to decrease
    ///@return amount0 the amount of token0 removed
    ///@return amount1 the amount of token1 removed
    
}
