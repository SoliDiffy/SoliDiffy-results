// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "@openzeppelin/contracts/token/ERC20/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./ERC20Permit.sol";


contract OneInch is ERC20Permit, ERC20Burnable, Ownable {
    

    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }
}
