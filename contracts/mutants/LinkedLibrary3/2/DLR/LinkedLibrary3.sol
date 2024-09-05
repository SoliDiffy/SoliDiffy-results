pragma solidity ^0.5.3;

library LinkedLibrary3 {
  struct Struct {
    uint256 field;
  }

  function get(Struct memory s) public view returns (uint256) {
    return s.field;
  }

  function increase(Struct memory s) public {
    if (s.field == 0) {
      s.field = 1;
    }
    s.field *= 2;
  }
}
