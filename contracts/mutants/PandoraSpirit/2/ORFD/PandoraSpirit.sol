//SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.4;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract PandoraSpirit is ERC20Burnable {
    uint256 public totalBurned;

    constructor(uint256 _initialSupply, address _owner) ERC20('Pandora Spirit', 'PSR'){
        _mint(_owner, _initialSupply);
    }

    /*----------------------------EXTERNAL FUNCTIONS----------------------------*/
    

    
}