// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.6.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ERC20Mock6Decimals is ERC20("ERC20Mock6decimals", "MCK") {
    bool public transferFromCalled = false;

    bool public transferCalled = false;
    address public transferRecipient = address(0);
    uint256 public transferAmount = 0;
    uint8 private _decimals;

    constructor () public {
        _decimals = 6;
    }

    function mint(address user, uint256 amount) public {
        _mint(user, amount);
    }

    

    
}
