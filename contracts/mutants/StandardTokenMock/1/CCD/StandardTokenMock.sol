pragma solidity 0.5.4;


import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";


// mock class using BasicToken
contract StandardTokenMock is ERC20 {
  uint256 public decimals;
  string public name;
  string public symbol;

  
}
