pragma solidity =0.6.10;

pragma experimental ABIEncoderV2;

import '../../contracts/core/MarginCalculator.sol';

//import {MarginVault} from "../../contracts/libs/MarginVault.sol";

contract MarginCalculatorHarness {
  // we are assuming one short otoken, one long otoken and one collateral
  //	mapping :	collateral amount => short amount => long amount => collateralAsset
  mapping(uint256 => mapping(uint256 => mapping(uint256 => uint256))) internal excessCollateral;

  

  

  mapping(address => uint256) internal expiredPayoutRate;

  function getExpiredPayoutRate(address _otoken) external view returns (uint256) {
    return expiredPayoutRate[_otoken];
  }
}
