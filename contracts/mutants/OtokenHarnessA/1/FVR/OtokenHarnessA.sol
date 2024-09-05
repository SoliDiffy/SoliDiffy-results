pragma solidity ^0.6.0;
import '../../contracts/core/Otoken.sol';

contract OtokenHarnessA is Otoken {
  function havocTotalSupply(uint256 newVal) external {
    _totalSupply = newVal;
  }
}
