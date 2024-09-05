pragma solidity ^0.5.13;
// solhint-disable no-unused-vars

/**
 * @title A mock GoldToken for testing.
 */
contract MockGoldToken {
  uint8 public constant decimals = 18;
  uint256 public totalSupply;
  mapping(address => uint256) balances;

  function setTotalSupply(uint256 value) public {
    totalSupply = value;
  }

  function transfer(address, uint256) public pure returns (bool) {
    return true;
  }

  function transferFrom(address, address, uint256) public pure returns (bool) {
    return true;
  }

  function setBalanceOf(address a, uint256 value) public {
    balances[a] = value;
  }

  function balanceOf(address a) public view returns (uint256) {
    return balances[a];
  }

}
