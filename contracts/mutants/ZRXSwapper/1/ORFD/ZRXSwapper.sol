// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4 <0.9.0;

import './AsyncSwapper.sol';

interface IZRXSwapper is IAsyncSwapper {
  error TradeReverted();

  // solhint-disable-next-line func-name-mixedcase
  function ZRX() external view returns (address);
}

contract ZRXSwapper is IZRXSwapper, AsyncSwapper {
  using SafeERC20 for IERC20;

  // solhint-disable-next-line var-name-mixedcase
  address public immutable override ZRX;

  constructor(
    address _governor,
    address _tradeFactory,
    // solhint-disable-next-line var-name-mixedcase
    address _ZRX
  ) AsyncSwapper(_governor, _tradeFactory) {
    ZRX = _ZRX;
  }

  
}
