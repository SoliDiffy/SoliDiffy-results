pragma solidity >=0.6.0 <0.7.0;

import "../utils/UInt256Array.sol";

contract UInt256ArrayExposed {
  using UInt256Array for uint256[];

  uint256[] internal array;

  

  function remove(uint256 index) external {
    array.remove(index);
  }

  function toArray() external view returns (uint256[] memory) {
    return array;
  }
}