// SPDX-License-Identifier: MIT

pragma solidity 0.7.6;
pragma abicoder v2;

import '../../interfaces/IUniswapAddressHolder.sol';

contract UniswapAddressHolder is IUniswapAddressHolder {
    address public override nonfungiblePositionManagerAddress;
    address public override uniswapV3FactoryAddress;
    address public override swapRouterAddress;

    constructor(
        address _nonfungiblePositionManagerAddress,
        address _uniswapV3FactoryAddress,
        address _swapRouterAddress
    ) {
        nonfungiblePositionManagerAddress = _nonfungiblePositionManagerAddress;
        uniswapV3FactoryAddress = _uniswapV3FactoryAddress;
        swapRouterAddress = _swapRouterAddress;
    }

    ///@notice Set the address of the non fungible position manager
    ///@param newAddress The address of the non fungible position manager
    

    ///@notice Set the address of the Uniswap V3 factory
    ///@param newAddress The address of the Uniswap V3 factory
    

    ///@notice Set the address of the swap router
    ///@param newAddress The address of the swap router
    
}
