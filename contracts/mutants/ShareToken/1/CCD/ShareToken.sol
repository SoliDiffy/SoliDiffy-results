pragma solidity ^0.5.2;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Mintable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Burnable.sol";

contract ShareToken is ERC20Mintable {
    uint256 public decimals;
    string public name;
    string public symbol;

    

    function burn(address account, uint256 amount) public onlyMinter {
        _burn(account, amount);
    }
}
