// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.6.12;
import "../converter/types/liquid-token/DynamicLiquidTokenConverterFactory.sol";
import "../token/DSToken.sol";

/*
    Utils test helper that exposes the converter factory functions
*/
contract TestDynamicLiquidTokenConverterFactory is DynamicLiquidTokenConverterFactory {
    DynamicLiquidTokenConverter public createdConverter;
    DSToken public createdToken;

    

    
}
