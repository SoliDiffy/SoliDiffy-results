pragma solidity ^0.5.13;

contract MethodsAddedContract {
  uint256 i = 3;

  function someMethod1(uint256 u) public {
    i = u;
  }

  function someMethod2(uint256 s) public pure returns (uint256) {
    return s + 1;
  }

  function newMethod1() external view returns (uint256) {
    return i;
  }

  function newMethod2(uint256 p) public payable returns (uint256) {
    return i + 2 + p;
  }

}
