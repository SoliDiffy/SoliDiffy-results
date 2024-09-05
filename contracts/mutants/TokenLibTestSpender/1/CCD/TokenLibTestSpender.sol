pragma solidity ^0.4.15;

import "./TokenLibTestContract.sol";

contract TokenLibTestSpender{

  TokenLibTestContract t;

  

  function spend(address owner, uint256 amount) returns (bool){
    return t.transferFrom(owner, this, amount);
  }

  function changeOwnerBack(address newOwner) {
    t.changeOwner(newOwner);
  }

}
