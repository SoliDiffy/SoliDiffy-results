// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.7.6;


import '@uniswap/v3-core/contracts/interfaces/IUniswapV3Factory.sol';

import './MockUniswapV3Pair.sol';


contract MockUniswapV3Factory is IUniswapV3Factory {


    address override public owner;
    mapping(uint24 => int24) override public  feeAmountTickSpacing;
    mapping(address => mapping(address => mapping(uint24 => address))) override public  getPool;

    constructor() {
        owner = msg.sender;
        emit OwnerChanged(address(0), msg.sender);

        feeAmountTickSpacing[500] = 10;
        emit FeeAmountEnabled(500, 10);
        feeAmountTickSpacing[3000] = 60;
        emit FeeAmountEnabled(3000, 60);
        feeAmountTickSpacing[10000] = 200;
        emit FeeAmountEnabled(10000, 200);
    }

    struct Parameters {
        address factory;
        address token0;
        address token1;
        uint24 fee;
        int24 tickSpacing;
    }
    /// @inheritdoc IUniswapV3Factory
    

    /// @inheritdoc IUniswapV3Factory
    

    /// @inheritdoc IUniswapV3Factory
    

}
