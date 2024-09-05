// SPDX-License-Identifier: MIT

pragma solidity 0.8.3;

interface IUniswapRouterProxy
{
    /* ======== PUBLIC VIEW FUNCTIONS ======== */

    function getPairAddress(
        address _tokenA,
        address _tokenB
        ) external view returns (address);

    function getAddLiquidityAmounts(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin
        ) external returns (uint amountB, uint amountA);

    /* ======== USER FUNCTIONS ======== */

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
        ) external returns (uint liquidity, uint amountA, uint amountB);

    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
        ) external payable returns (uint liquidity, uint amountToken, uint amountETH);

    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
        ) external returns (uint amountB, uint amountA);

    function removeLiquidityETH(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
        ) external returns (uint amountToken, uint amountETH);
}
