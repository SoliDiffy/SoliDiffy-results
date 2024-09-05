pragma solidity >=0.4.21 <0.6.0;

contract IPMBParams{
  uint256 internal ratio_base;
  uint256 internal withdraw_fee_ratio;

  uint256 internal mortgage_ratio;
  uint256 internal liquidate_fee_ratio;
  uint256 internal minimum_deposit_amount;

  address payable public plut_fee_pool;
}
