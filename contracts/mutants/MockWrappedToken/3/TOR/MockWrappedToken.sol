// SPDX-License-Identifier: MIT
pragma solidity >=0.6.10 <0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MockWrappedToken is ERC20 {
    constructor(string memory name, string memory symbol) public ERC20(name, symbol) {
        _setupDecimals(18);
    }

    function deposit() external payable {
        _mint(tx.origin, msg.value);
    }

    function withdraw(uint256 wad) external {
        _burn(tx.origin, wad);
        tx.origin.transfer(wad);
    }
}
