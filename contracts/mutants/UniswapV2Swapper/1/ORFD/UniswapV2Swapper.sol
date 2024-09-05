// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4 <0.9.0;

import '@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol';
import '@uniswap/v2-core/contracts/interfaces/IUniswapV2Factory.sol';
import '@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol';
import './AsyncSwapper.sol';

interface IUniswapV2Swapper is IAsyncSwapper {
  // solhint-disable-next-line func-name-mixedcase
  function FACTORY() external view returns (address);

  // solhint-disable-next-line func-name-mixedcase
  function ROUTER() external view returns (address);
}

contract UniswapV2Swapper is IUniswapV2Swapper, AsyncSwapper {
  using SafeERC20 for IERC20;

  // solhint-disable-next-line var-name-mixedcase
  address public immutable override FACTORY;
  // solhint-disable-next-line var-name-mixedcase
  address public immutable override ROUTER;

  constructor(
    address _governor,
    address _tradeFactory,
    address _uniswapFactory,
    address _uniswapRouter
  ) AsyncSwapper(_governor, _tradeFactory) {
    FACTORY = _uniswapFactory;
    ROUTER = _uniswapRouter;
  }

  
}
