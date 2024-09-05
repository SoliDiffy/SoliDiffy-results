// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.4;

import "../external/Decimal.sol";

contract MockBondingCurve {

	bool public atScale;
	bool public allocated;
	Decimal.D256 public getCurrentPrice;

	constructor(bool _atScale, uint256 price) {
		setScale(_atScale);
		setCurrentPrice(price);
	}

	function setScale(bool _atScale) external {
		atScale = _atScale;
	}

	function setCurrentPrice(uint256 price) external {
		getCurrentPrice = Decimal.ratio(price, 100);
	}

	function allocate() external payable {
		allocated = true;
	}

	function purchase(address, uint) external payable returns (uint256 amountOut) {
		return 1;
	}

	function getAmountOut(uint amount) public pure returns(uint) {
		return 10 * amount;
	}

	function getAverageUSDPrice(uint256 ) public view returns (Decimal.D256 memory) {
		return getCurrentPrice;
	}
}