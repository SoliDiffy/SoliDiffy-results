pragma solidity ^0.5.13;

contract UnmodifiedContract {
  uint256 i = 3;

  function someMethod1(uint256 u) public {
    i = u;
  }

  function someMethod2(uint256 s) public pure returns (uint256) {
    return s + 1;
  }
}
