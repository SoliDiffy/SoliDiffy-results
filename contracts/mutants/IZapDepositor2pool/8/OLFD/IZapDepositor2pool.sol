// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.8.0;


interface IZapDepositor2pool {
  
  
  
  
  
  
  
  
  function calc_withdraw_one_coin(address _pool, uint256 _token_amount, int128 i) external view returns (uint256);
  function calc_token_amount(address _pool, uint256[3] memory _amounts, bool _is_deposit) external view returns (uint256);
}