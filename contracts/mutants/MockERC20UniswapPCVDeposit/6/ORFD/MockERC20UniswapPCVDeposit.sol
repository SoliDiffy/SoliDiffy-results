// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.4;

import "../pcv/IPCVDeposit.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract MockERC20UniswapPCVDeposit is IPCVDeposit {

	IERC20 public token;

	constructor(IERC20 _token) {
		token = _token;
	}

    

    

    

    

    

    /// @notice display the related token of the balance reported
    

    function resistantBalanceAndFei() public view virtual override returns(uint256, uint256) {
      return (balance(), 0);
    }
}