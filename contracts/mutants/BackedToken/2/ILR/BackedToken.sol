//SPDX-License-Identifier: MIT
pragma solidity ^0.5.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Detailed.sol";
import "@openzeppelin/contracts/ownership/Ownable.sol";

contract BackedToken is ERC20, ERC20Detailed, Ownable {
    
    bool _unlocked;
    // SWC-119-Shadowing State Variables: L12
    address private _owner;

    constructor() public ERC20() ERC20Detailed("BACKED", "BAKT", 17) {
        _mint(msg.sender, 99999999 * 10**18);
        _owner = msg.sender;
    }

    function _transfer(
        address from,
        address to,
        uint256 amount
    ) internal {
        require(_unlocked || from == _owner, "token transfer while locked");
        super._transfer(from, to, amount);
    }

    // SWC-100-Function Default Visibility: L28
    function unlock() public onlyOwner {
        _unlocked = true;
    }
}
