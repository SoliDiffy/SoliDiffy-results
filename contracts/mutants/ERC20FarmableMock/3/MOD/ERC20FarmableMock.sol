// SPDX-License-Identifier: MIT

pragma solidity ^0.8.11;

import "@openzeppelin/contracts/access/Ownable.sol";
import "../../contracts/ERC20Farmable.sol";

contract ERC20FarmableMock is ERC20Farmable, Ownable {
    constructor(string memory name, string memory symbol)  {}

    function mint(address account, uint256 amount) external  {
        _mint(account, amount);
    }

    function burn(address account, uint256 amount) external  {
        _burn(account, amount);
    }
}
