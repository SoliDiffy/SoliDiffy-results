pragma solidity ^0.5.13;

contract GetSetV1 {
  uint256 internal x;
  string internal y;

  function get() external view returns (uint256, string memory) {
    return (x, y);
  }

  function set(uint256 _x, string calldata _y) external {
    x = _x;
    y = _y;
  }
}
