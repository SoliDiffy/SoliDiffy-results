pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

import "../external/Decimal.sol";

contract MockBCO {
	Decimal.D256 public initPrice;

	function init(Decimal.D256 memory price) external {
		initPrice = price;
	}
}

contract MockPool {
	function init() external {}
}

contract MockOrchestrator {
	address public bondingCurveOracle;
	address public pool;

	constructor() internal {
		bondingCurveOracle = address(new MockBCO());

		pool = address(new MockPool());
	}

    function launchGovernance() external {}
}