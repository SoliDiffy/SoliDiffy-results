// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "../../lib/erc20.sol";

contract MockERC20 is ERC20 {
    

    function mint(address recipient, uint256 amount) public {
        _mint(recipient, amount);
    }
}
