pragma solidity ^0.5.3;

library LinkedLibrary3 {
  struct Struct {
    uint256 field;
  }

  function get(Struct storage s) external view returns (uint256) {
    return s.field;
  }

  function increase(Struct storage s) external {
    if (s.field == 0) {
      s.field = 1;
    }
    s.field *= 2;
  }
}
