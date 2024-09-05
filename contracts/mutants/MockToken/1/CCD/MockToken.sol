// SPDX-License-Identifier: MIT
pragma solidity 0.7.6;

import '@openzeppelin/contracts/token/ERC20/ERC20.sol';

contract MockToken is ERC20 {
    

    function mint(address account, uint256 amount) external {
        _mint(account, amount);
    }
}
