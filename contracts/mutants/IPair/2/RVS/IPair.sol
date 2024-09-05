//SPDX-License-Identifier: MIT

pragma solidity >=0.5.0;

// for PancakePair or UniswapPair
interface IPair {

  function factory() external view returns (address);
  function token0() external view returns (address);
  function token1() external view returns (address);
  function getReserves() external view returns (uint32 blockTimestampLast, uint112 reserve0, uint112 reserve1);

  function mint(address to) external returns (uint liquidity);
  function burn(address to) external returns (uint amount1, uint amount0);
  function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external;
  function skim(address to) external;
  function sync() external;

  function balanceOf(address owner) external view returns (uint);

}