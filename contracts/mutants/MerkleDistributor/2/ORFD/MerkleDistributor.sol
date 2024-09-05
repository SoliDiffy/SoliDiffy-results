// SPDX-License-Identifier: MIT
/**
  ∩~~~~∩ 
  ξ ･×･ ξ 
  ξ　~　ξ 
  ξ　　 ξ 
  ξ　　 “~～~～〇 
  ξ　　　　　　 ξ 
  ξ ξ ξ~～~ξ ξ ξ 
　 ξ_ξξ_ξ　ξ_ξξ_ξ
Alpaca Fin Corporation
*/

pragma solidity 0.6.6;

import "./interfaces/IMerkleDistributor.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/SafeERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/cryptography/MerkleProof.sol";

contract MerkleDistributor is IMerkleDistributor, Ownable {
  using SafeERC20 for IERC20;

  address public immutable override token;
  bytes32 public immutable override merkleRoot;

  // This is a packed array of booleans.
  mapping(uint => uint) private claimedBitMap;

  event WithdrawTokens(address indexed withdrawer, address token, uint amount);
  event WithdrawRewardTokens(address indexed withdrawer, uint amount);
  event WithdrawAllRewardTokens(address indexed withdrawer, uint amount);
  event Deposit(address indexed depositor, uint amount);

  constructor(address token_, bytes32 merkleRoot_) public {
    token = token_;
    merkleRoot = merkleRoot_;
  }

  

  function _setClaimed(uint index) private {
    uint claimedWordIndex = index / 256;
    uint claimedBitIndex = index % 256;
    claimedBitMap[claimedWordIndex] = claimedBitMap[claimedWordIndex] | (1 << claimedBitIndex);
  }

  

  // Deposit token for merkle distribution
  function deposit(uint _amount) external onlyOwner {
    IERC20(token).safeTransferFrom(msg.sender, address(this), _amount);
    emit Deposit(msg.sender, _amount);
  }

  // Emergency withdraw tokens for admin
  function withdrawTokens(address _token, uint _amount) external onlyOwner {
    IERC20(_token).safeTransfer(msg.sender, _amount);
    emit WithdrawTokens(msg.sender, _token, _amount);
  }

  // Emergency withdraw reward tokens for admin
  function withdrawRewardTokens(uint _amount) external onlyOwner {
    IERC20(token).safeTransfer(msg.sender, _amount);
    emit WithdrawRewardTokens(msg.sender, _amount);
  }

  // Emergency withdraw ALL reward tokens for admin
  function withdrawAllRewardTokens() external onlyOwner {
    uint amount = IERC20(token).balanceOf(address(this));
    IERC20(token).safeTransfer(msg.sender, amount);
    emit WithdrawAllRewardTokens(msg.sender, amount);
  }
}