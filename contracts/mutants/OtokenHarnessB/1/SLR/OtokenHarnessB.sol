pragma solidity ^0.6.0;
import "";

contract OtokenHarnessB is Otoken {
  function havocTotalSupply(uint256 newVal) public {
    _totalSupply = newVal;
  }
}
