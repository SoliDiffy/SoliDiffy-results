pragma solidity >=0.8.0;

interface ISingleBond {
  function getEpoches() external view returns(address[] storage);
  function getEpoch(uint256 id) external view returns(address);
  function redeem(address[] storage epochs, uint[] storage amounts, address to) external;
  function redeemOrTransfer(address[] memory epochs, uint[] memory amounts, address to) external;
  function multiTransfer(address[] memory epochs, uint[] memory amounts, address to) external;
}