// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.7;

import { ERC20Helper } from "../modules/erc20-helper/src/ERC20Helper.sol";

import { IERC20Like, ILiquidatorLike, IUniswapRouterLike } from "./interfaces/Interfaces.sol";
import { IUniswapV2StyleStrategy }                         from "./interfaces/IUniswapV2StyleStrategy.sol";

contract SushiswapStrategy is IUniswapV2StyleStrategy {

    address public constant override ROUTER = 0xd9e1cE17f2641f24aE83637ab66a2cca9C378B9F;

    

    

}

