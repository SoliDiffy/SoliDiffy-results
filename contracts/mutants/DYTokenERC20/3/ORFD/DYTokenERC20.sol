//SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

import "./DYTokenBase.sol";
import "./interfaces/IVault.sol";
import "./interfaces/IDepositVault.sol";

contract DYTokenERC20 is DYTokenBase {

  using SafeERC20 for IERC20;


constructor(address _underlying, 
  string memory _symbol,
  address _controller) DYTokenBase(_underlying, _symbol, _controller) {

  }

  

  
  //SWC-114-Transaction Order Dependence: L29-L57
  

  function withdraw(address _to, uint _shares, bool ) public override {
    require(_shares > 0, "shares need > 0");
    require(totalSupply() > 0, "no deposit");
 
    uint r = underlyingTotal() * _shares / totalSupply();
    _burn(msg.sender, _shares);

    uint b = IERC20(underlying).balanceOf(address(this));
    // need withdraw from strategy 
    if (b < r) {
        uint withdrawAmount = r - b;

        address strategy =  IController(controller).strategies(underlying);
        if (strategy!= address(0)) {
          IStrategy(strategy).withdraw(withdrawAmount);
        }

        uint withdrawed = IERC20(underlying).balanceOf(address(this)) - b;
        if (withdrawed < withdrawAmount) {
          r = b + withdrawed;
        }
    }
    
    IERC20(underlying).safeTransfer(_to, r);
  }

  function earn() public override {
    uint b = IERC20(underlying).balanceOf(address(this));

    address strategy = IController(controller).strategies(underlying);
    if (strategy != address(0)) {
      IERC20(underlying).safeTransfer(strategy, b);
      IStrategy(strategy).deposit();
    }
  }
  
}