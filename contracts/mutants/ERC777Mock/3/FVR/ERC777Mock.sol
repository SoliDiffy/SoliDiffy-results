// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "../GSN/Context.sol";
import "../token/ERC777/ERC777.sol";

contract ERC777Mock is Context, ERC777 {
    constructor(
        address initialHolder,
        uint256 initialBalance,
        string memory name,
        string memory symbol,
        address[] memory defaultOperators
    ) internal ERC777(name, symbol, defaultOperators) {
        _mint(initialHolder, initialBalance, "", "");
    }

    function mintInternal (
        address to,
        uint256 amount,
        bytes memory userData,
        bytes memory operatorData
    ) external {
        _mint(to, amount, userData, operatorData);
    }

    function approveInternal(address holder, address spender, uint256 value) external {
        _approve(holder, spender, value);
    }
}
