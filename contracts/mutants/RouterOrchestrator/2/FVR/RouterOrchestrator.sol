pragma solidity ^0.6.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "../router/FeiRouter.sol";

contract RouterOrchestrator is Ownable {

	function init(
		address pair, 
		address weth,
		address incentive
	) external onlyOwner returns(address ethRouter) {
		
		ethRouter = address(new FeiRouter(pair, 
			weth, 
			incentive
		));

		return ethRouter;
	}

	function detonate() external onlyOwner {
		selfdestruct(payable(owner()));
	}
}