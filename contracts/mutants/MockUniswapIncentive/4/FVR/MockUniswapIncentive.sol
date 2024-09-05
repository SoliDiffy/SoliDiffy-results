// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.4;

import "./MockIncentive.sol";
import "../external/Decimal.sol";

contract MockUniswapIncentive is MockIncentive {

	constructor(address core) MockIncentive(core) {}

    bool public isParity = false;
    bool public isExempt = false;

    function incentivize(
    	address sender, 
    	address recipient, 
    	address, 
    	uint256
    ) public override {
        if (!isExempt) {
            super.incentivize(sender, recipient, address(0), 0);
        }
    }

    function isIncentiveParity() public view returns (bool) {
        return isParity;
    }

    function setIncentiveParity(bool _isParity) external {
        isParity = _isParity;
    }

    function isExemptAddress(address) external view returns (bool) {
        return isExempt;
    }

    function setExempt(bool exempt) external {
        isExempt = exempt;
    }

    function updateOracle() external pure returns(bool) {
        return true;
    }

    function setExemptAddress(address account, bool _isExempt) external {}

    function getBuyIncentive(uint amount) external pure returns(uint,        
        uint32 weight,
        Decimal.D256 memory initialDeviation,
        Decimal.D256 memory finalDeviation
    ) {
        return (amount * 10 / 100, weight, initialDeviation, finalDeviation);
    }

    function getSellPenalty(uint amount) external pure returns(uint,    
        Decimal.D256 memory initialDeviation,
        Decimal.D256 memory finalDeviation) 
    {
        return (amount * 10 / 100, initialDeviation, finalDeviation);
    }
}