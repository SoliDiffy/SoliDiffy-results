// SPDX-License-Identifier: MIT

pragma solidity ^0.6.12;

import "@openzeppelin/contracts/token/ERC777/ERC777.sol";

contract ERC777Mintable is ERC777 {

  

  function mint(address to, uint256 amount, bytes memory userData, bytes memory operatorData) external returns (address) {
    _mint(to, amount, userData, operatorData);
  }

}
