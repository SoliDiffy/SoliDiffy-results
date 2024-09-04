// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "../core/Ownable.sol";

contract AvatarArtERC20 is ERC20, Ownable{
    
    
    function mint(address account, uint256 amount) external onlyOwner{
        _mint(account, amount);
    }
    
    function burn(address account, uint256 amount) external onlyOwner{
        _burn(account, amount);
    }
}