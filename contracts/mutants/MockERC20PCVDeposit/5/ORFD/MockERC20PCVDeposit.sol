// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.4;

import "../pcv/IPCVDeposit.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract MockERC20PCVDeposit is IPCVDeposit {

	address payable public beneficiary;
    IERC20 public token;
    uint256 public total;

	constructor(address payable _beneficiary, IERC20 _token) {
		beneficiary = _beneficiary;
        token = _token;
	}

    

    

    

    

    

    /// @notice display the related token of the balance reported
    function balanceReportedIn() public view override returns (address) {
        return address(token);
    }

    function resistantBalanceAndFei() public view virtual override returns(uint256, uint256) {
      return (balance(), 0);
    }
    
    function setBeneficiary(address payable _beneficiary) public {
        beneficiary = _beneficiary;
    }
}