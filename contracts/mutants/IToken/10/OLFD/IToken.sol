pragma solidity ^0.4.23;

interface IToken {
  
  
  
  
  
  
  function transfer(address, uint) external returns (bool);
  function transferFrom(address, address, uint) external returns (bool);
  function approve(address, uint) external returns (bool);
  function increaseApproval(address, uint) external returns (bool);
  function decreaseApproval(address, uint) external returns (bool);
  event Transfer(address indexed from, address indexed to, uint amt);
  event Approval(address indexed owner, address indexed spender, uint amt);
}

interface TokenIdx {
  
  
  
  
  function balanceOf(address, bytes32, address) external view returns (uint);
  function allowance(address, bytes32, address, address) external view returns (uint);
}
