
// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;

import "@openzeppelin/contracts/token/ERC20/ERC20Capped.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BOOToken is ERC20Capped, Ownable {
    constructor (
            uint256 _totalSupply
        ) internal ERC20Capped(_totalSupply) ERC20('Booster-Token', 'BOO') {
    }

    mapping(address => bool) public mintWhitelist;

    function setMintWhitelist(address _account, bool _enabled) public onlyOwner {
        mintWhitelist[_account] = _enabled;
    }

    function mint(address _account, uint256 _amount) public {
        require(mintWhitelist[msg.sender], 'not allow');
        _mint(_account, _amount);
    }

    function burn(uint256 _amount) public onlyOwner {
        _burn(msg.sender, _amount);
    }
}

