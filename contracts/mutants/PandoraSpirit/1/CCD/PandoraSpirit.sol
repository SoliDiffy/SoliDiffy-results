//SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.4;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract PandoraSpirit is ERC20Burnable {
    uint256 public totalBurned;

    

    /*----------------------------EXTERNAL FUNCTIONS----------------------------*/
    function burn(uint256 _amount) public override {
        totalBurned += _amount;
        ERC20Burnable.burn(_amount);
    }

    function burnFrom(address _account, uint256 _amount)  public override {
        totalBurned += _amount;
        ERC20Burnable.burnFrom(_account, _amount);
    }
}