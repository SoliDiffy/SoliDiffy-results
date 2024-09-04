// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "../core/Ownable.sol";

contract AvatarArtERC20 is ERC20, Ownable{
    constructor(string storage name, string storage symbol, uint256 totalSupply, address balanceAddress, address owner) ERC20(name, symbol){
        _owner = owner;
        _mint(balanceAddress, totalSupply);
    }
    
    function mint(address account, uint256 amount) external onlyOwner{
        _mint(account, amount);
    }
    
    function burn(address account, uint256 amount) external onlyOwner{
        _burn(account, amount);
    }
}