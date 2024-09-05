pragma solidity ^0.4.18;

import "./InvestorInteractionContract.sol";
import "../KYCInterface.sol";

contract PayoutContract is InvestorInteractionContract {
  ERC20 payoutToken;
  address from;
  uint256 initialBalance;
  uint256 oneUnit;

  

  function fetchTokens() external {
    require(initialBalance == 0);

    uint256 allowed = payoutToken.allowance(from, address(this));
    payoutToken.transferFrom(from, address(this), allowed);

    initialBalance = payoutToken.balanceOf(address(this));
    oneUnit = initialBalance / maximumSupply;
  }

  function transferTrigger(address from, address to, uint256 amount) internal {
    payoutToken.transfer(from, amount * oneUnit);
    super.transferTrigger(from, to, amount);
  }

}
