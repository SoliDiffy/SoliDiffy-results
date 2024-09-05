// SPDX-License-Identifier: MIT

pragma solidity 0.7.6;
pragma abicoder v2;

import '@uniswap/v3-periphery/contracts/interfaces/INonfungiblePositionManager.sol';
import '../helpers/ERC20Helper.sol';
import '../helpers/UniswapNFTHelper.sol';
import '../utils/Storage.sol';
import '../../interfaces/actions/IIncreaseLiquidity.sol';

///@notice action to increase the liquidity of a V3 position
contract IncreaseLiquidity is IIncreaseLiquidity {
    ///@notice emitted when liquidity is increased
    ///@param positionManager address of the position manager which increased liquidity
    ///@param tokenId id of the position
    event LiquidityIncreased(address indexed positionManager, uint256 tokenId);

    ///@notice increase the liquidity of a UniswapV3 position
    ///@param tokenId the id of the position token
    ///@param amount0Desired the desired amount of token0
    ///@param amount1Desired the desired amount of token1
    
}
