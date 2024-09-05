// SPDX-License-Identifier: MIT

pragma solidity 0.8.4;
pragma experimental ABIEncoderV2;

interface IUniswapLP {
    function token0() external view returns (address);

    function token1() external view returns (address);

    function getReserves()
        external
        view
        returns (
            uint32 blockTimestampLast,
            uint112 reserve0,
            uint112 reserve1
        );

    function price0CumulativeLast() external view returns (uint256);

    function price1CumulativeLast() external view returns (uint256);

    function getTokenWeights() external view returns (uint32 tokenWeight1, uint32 tokenWeight0);
}
