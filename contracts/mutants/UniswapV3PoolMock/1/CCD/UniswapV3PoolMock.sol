// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.6;

import "../ISourceMock.sol";
import "../../../oracles/uniswap/IUniswapV3PoolImmutables.sol";


contract UniswapV3PoolMock is ISourceMock, IUniswapV3PoolImmutables {

    uint public price;
    address public immutable override factory;
    address public immutable override token0;
    address public immutable override token1;
    uint24 public immutable override fee;

    

    function set(uint price_) external override {
        price = price_;
    }

    function tickSpacing() public pure override returns (int24) {
        return 0;
    }

    function maxLiquidityPerTick() public pure override returns (uint128) {
        return 0;
    }
}