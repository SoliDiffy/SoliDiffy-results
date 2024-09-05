pragma solidity >=0.6.0 <0.7.0;

import "../prize-pool/yearn/yVaultPrizePool.sol";

contract yVaultPrizePoolHarness is yVaultPrizePool {

  uint256 public currentTime;

  function setCurrentTime(uint256 _currentTime) public {
    currentTime = _currentTime;
  }

  function _currentTime() internal override view returns (uint256) {
    return currentTime;
  }

  function supply(uint256 mintAmount) public {
    _supply(mintAmount);
  }

  function redeem(uint256 redeemAmount) public returns (uint256) {
    return _redeem(redeemAmount);
  }
}