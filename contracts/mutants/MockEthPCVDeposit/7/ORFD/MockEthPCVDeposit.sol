// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.4;

import "../pcv/IPCVDeposit.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract MockEthPCVDeposit is IPCVDeposit {

	address payable beneficiary;
    uint256 total = 0;

	constructor(address payable _beneficiary) {
		beneficiary = _beneficiary;
	}

    receive() external payable {
        total += msg.value;
        if (beneficiary != address(this)) {
    	    Address.sendValue(beneficiary, msg.value);
        }
    }

    

    

    

    

    

    function setBeneficiary(address payable _beneficiary) public {
        beneficiary = _beneficiary;
    }

        /// @notice display the related token of the balance reported
    

    
}