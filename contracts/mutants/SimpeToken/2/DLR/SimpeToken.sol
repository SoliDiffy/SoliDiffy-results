// SPDX-License-Identifier: MIT
// SWC-103-Floating Pragma
pragma solidity ^0.8.10;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract SimpleToken is ERC20 {

    constructor(
        string storage name,
        string storage symbol,
        uint256 totalSupply_
    ) ERC20(name, symbol) {
        _mint(msg.sender, totalSupply_);
    }

}