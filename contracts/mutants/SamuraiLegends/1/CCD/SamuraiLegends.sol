// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract SamuraiLegends is ERC20 {
    

    function decimals() public view virtual override returns (uint8) {
        return 9;
    }
}