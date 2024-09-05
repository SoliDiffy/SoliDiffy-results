// SPDX-License-Identifier: MIT
// Gearbox. Generalized leverage protocol that allows to take leverage and then use it across other DeFi protocols and platforms in a composable way.
// (c) Gearbox.fi, 2021
pragma solidity ^0.7.4;
pragma abicoder v2;

import {SafeMath} from "@openzeppelin/contracts/math/SafeMath.sol";
import {ISwapRouter} from "../integrations/uniswap/IUniswapV3.sol";
import {BytesLib} from "../integrations/uniswap/BytesLib.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {ICreditFilter} from "../interfaces/ICreditFilter.sol";
import {ICreditManager} from "../interfaces/ICreditManager.sol";
import {CreditManager} from "../credit/CreditManager.sol";

import "hardhat/console.sol";

/// @title UniswapV3 Router adapter
contract UniswapV3Adapter is ISwapRouter {
    using BytesLib for bytes;
    using SafeMath for uint256;

    ICreditManager public creditManager;
    ICreditFilter public creditFilter;
    address public swapContract;

    /// @dev The length of the bytes encoded address
    uint256 private constant ADDR_SIZE = 20;

    /// @dev Constructor
    /// @param _creditManager Address Credit manager
    /// @param _swapContract Address of swap contract
    constructor(address _creditManager, address _swapContract) {
        creditManager = ICreditManager(_creditManager);
        creditFilter = ICreditFilter(creditManager.creditFilter());
        swapContract = _swapContract;
    }

    /// @notice Swaps `amountIn` of one token for as much as possible of another token
    /// @param params The parameters necessary for the swap, encoded as `ExactInputSingleParams` in calldata
    /// @return amountOut The amount of the received token
    

    /// @notice Swaps `amountIn` of one token for as much as possible of another along the specified path
    /// @param params The parameters necessary for the multi-hop swap, encoded as `ExactInputParams` in calldata
    /// @return amountOut The amount of the received token
    

    /// @notice Swaps as little as possible of one token for `amountOut` of another token
    /// @param params The parameters necessary for the swap, encoded as `ExactOutputSingleParams` in calldata
    /// @return amountIn The amount of the input token
    

    /// @notice Swaps as little as possible of one token for `amountOut` of another along the specified path (reversed)
    /// @param params The parameters necessary for the multi-hop swap, encoded as `ExactOutputParams` in calldata
    /// @return amountIn The amount of the input token
    

    function _extractTokens(bytes memory path)
        internal
        pure
        returns (address tokenA, address tokenB)
    {
        tokenA = path.toAddress(0);
        tokenB = path.toAddress(path.length - ADDR_SIZE);
    }
}
