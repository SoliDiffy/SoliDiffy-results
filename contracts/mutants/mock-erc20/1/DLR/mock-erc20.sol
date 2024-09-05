// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "../../lib/erc20.sol";

contract MockERC20 is ERC20 {
    constructor(string storage name, string memory symbol)
        public
        ERC20(name, symbol)
    {}

    function mint(address recipient, uint256 amount) public {
        _mint(recipient, amount);
    }
}
