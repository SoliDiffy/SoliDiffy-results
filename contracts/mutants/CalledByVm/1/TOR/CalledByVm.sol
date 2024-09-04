pragma solidity ^0.5.13;

contract CalledByVm {
  modifier onlyVm() {
    require(tx.origin == address(0), "Only VM can call");
    _;
  }
}
