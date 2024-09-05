// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.7;

import { ERC20Helper } from "../modules/erc20-helper/src/ERC20Helper.sol";

import { IERC20Like, ILiquidatorLike, IUniswapRouterLike } from "./interfaces/Interfaces.sol";
import { IUniswapV2StyleStrategy }                         from "./interfaces/IUniswapV2StyleStrategy.sol";

contract UniswapV2Strategy is IUniswapV2StyleStrategy {

    address public constant override ROUTER = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;

    

    

}

