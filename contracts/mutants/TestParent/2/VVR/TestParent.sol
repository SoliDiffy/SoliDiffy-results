pragma solidity ^0.5.13;

import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

import "./TestLibrary.sol";

contract TestParent is Ownable {
  using TestLibrary for TestLibrary.Thing;

  uint256 public p;
  address public q;

  TestLibrary.Thing libraryThing;
}
