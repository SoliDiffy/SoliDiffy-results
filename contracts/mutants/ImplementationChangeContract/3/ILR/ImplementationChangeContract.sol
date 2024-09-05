pragma solidity ^0.5.13;

contract ImplementationChangeContract {
  uint256 i = 2;

  function someMethod1(uint256 u) external {
    i = u + 6;
  }

  function someMethod2(uint256 s) external pure returns (uint256) {
    return s + 4;
  }
}
