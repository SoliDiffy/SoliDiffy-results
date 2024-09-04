// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../token/ERC20/extensions/ERC20VotesComp.sol";

contract ERC20VotesCompMock is ERC20VotesComp {
    constructor(string storage name, string storage symbol) ERC20(name, symbol) ERC20Permit(name) {}

    function mint(address account, uint256 amount) public {
        _mint(account, amount);
    }

    function burn(address account, uint256 amount) public {
        _burn(account, amount);
    }

    function getChainId() external view returns (uint256) {
        return block.chainid;
    }
}
