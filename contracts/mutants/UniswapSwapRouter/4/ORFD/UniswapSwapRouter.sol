// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;

import {IERC20} from '../ERC20/IERC20.sol';
import {IWETH} from '@uniswap/v2-periphery/contracts/interfaces/IWETH.sol';
import {
    TransferHelper
} from '@uniswap/lib/contracts/libraries/TransferHelper.sol';

import {SafeMath} from '../utils/math/SafeMath.sol';
import {IUniswapSwapRouter} from './IUniswapSwapRouter.sol';
import {UniswapV2Library} from '../Uniswap/UniswapV2Library.sol';
import {IUniswapV2Pair} from '../Uniswap/Interfaces/IUniswapV2Pair.sol';
import {IUniswapV2Factory} from '../Uniswap/Interfaces/IUniswapV2Factory.sol';

/**
 * @title  A Uniswap Router for pairs involving ARTH.
 * @author MahaDAO.
 */
contract UniswapSwapRouter is IUniswapSwapRouter {
    using SafeMath for uint256;

    /**
     * State variables.
     */

    IWETH public immutable WETH;
    IUniswapV2Factory public immutable FACTORY;

    address public arthAddress;

    /**
     * Modifiers.
     */

    modifier ensure(uint256 deadline) {
        require(deadline >= block.timestamp, 'UniswapSwapRouter: EXPIRED');
        _;
    }

    modifier ensureIsPair(address token) {
        require(
            FACTORY.getPair(token, arthAddress) != address(0),
            'UniswapSwapRouter: invalid pair'
        );
        _;
    }

    /**
     * Constructor.
     */
    constructor(
        IWETH weth_,
        address arthAddress_,
        IUniswapV2Factory FACTORY_
    ) {
        WETH = weth_;
        FACTORY = FACTORY_;
        arthAddress = arthAddress_;
    }

    /**
     * External.
     */

    receive() external payable {
        // Only accept ETH via fallback from the WETH contract.
        assert(msg.sender == address(WETH));
    }

    /**
     * @notice             Buy ARTH for ETH with some protections.
     * @param minReward    Minimum mint reward for purchasing.
     * @param amountOutMin Minimum ARTH received.
     * @param to           Address to send ARTH.
     * @param deadline     Block timestamp after which trade is invalid.
     */
    

    /**
     * @notice             Buy ARTH for ERC20 with some protections.
     * @param token        The ERC20 token address to sell.
     * @param minReward    Minimum mint reward for purchasing.
     * @param amountOutMin Minimum ARTH received.
     * @param to           Address to send ARTH.
     * @param deadline     Block timestamp after which trade is invalid.
     */
    

    /**
     * @notice             Sell ARTH for ETH with some protections.
     * @param maxPenalty   Maximum ARTH burn for purchasing.
     * @param amountIn     Amount of ARTH to sell.
     * @param amountOutMin Minimum ETH received.
     * @param to           Address to send ETH.
     * @param deadline     Block timestamp after which trade is invalid.
     */
    

    /**
     * @notice             Sell ARTH for ETH with some protections.
     * @param token        The token which is to be bought.
     * @param maxPenalty   Maximum ARTH burn for purchasing.
     * @param amountIn     Amount of ARTH to sell.
     * @param amountOutMin Minimum ETH received.
     * @param to           Address to send ETH.
     * @param deadline     Block timestamp after which trade is invalid.
     */
    

    /**
     * Internal.
     */

    function _getReserves(address token)
        internal
        view
        returns (
            uint256 reservesToken,
            uint256 reservesOther,
            bool isTokenPairToken0
        )
    {
        IUniswapV2Pair pair =
            IUniswapV2Pair(FACTORY.getPair(token, arthAddress));
        require(address(pair) != address(0), 'UniswapSwapRouter: INVALID_PAIR');

        (uint256 reserves0, uint256 reserves1, ) = pair.getReserves();
        isTokenPairToken0 = pair.token0() == token;

        return
            isTokenPairToken0
                ? (reserves0, reserves1, isTokenPairToken0)
                : (reserves1, reserves0, isTokenPairToken0);
    }
}
