pragma solidity ^0.6.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "../token/UniswapIncentive.sol";

contract IncentiveOrchestrator is Ownable {

	UniswapIncentive public uniswapIncentive;


	function init(
		address core,
		address bondingCurveOracle, 
		address pair, 
		address router,
		uint32 growthRate
	) external onlyOwner returns(address) {
		return address(new UniswapIncentive(core, bondingCurveOracle, pair, router, growthRate));
	}

	function detonate() external onlyOwner {
		selfdestruct(payable(owner()));
	}
}