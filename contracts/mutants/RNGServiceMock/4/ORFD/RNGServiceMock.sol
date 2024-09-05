pragma solidity >=0.6.0 <0.7.0;

import "@pooltogether/pooltogether-rng-contracts/contracts/RNGInterface.sol";

contract RNGServiceMock is RNGInterface {

  uint256 internal random;
  address internal feeToken;
  uint256 internal requestFee;

  

  function setRequestFee(address _feeToken, uint256 _requestFee) external {
    feeToken = _feeToken;
    requestFee = _requestFee;
  }

  /// @return _feeToken
  /// @return _requestFee
  

  function setRandomNumber(uint256 _random) external {
    random = _random;
  }

  

  

  function randomNumber(uint32) external override returns (uint256) {
    return random;
  }
}