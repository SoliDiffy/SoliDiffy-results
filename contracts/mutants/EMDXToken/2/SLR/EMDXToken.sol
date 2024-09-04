// SPDX-License-Identifier: MIT

pragma solidity 0.8.10;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract EMDXToken is ERC20 {
    string public constant NAME = "";
    string public constant SYMBOL = "";
    uint256 public constant INITIAL_SUPPLY = 1000000000 * 10**18;

    constructor() ERC20(NAME, SYMBOL) {
        _mint(msg.sender, INITIAL_SUPPLY);
    }
}
