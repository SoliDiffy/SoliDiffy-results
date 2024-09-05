pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

import "./UniswapSingleEthRouter.sol";
import "../refs/IOracleRef.sol";
import "../token/IUniswapIncentive.sol";
import "./IFeiRouter.sol";

contract FeiRouter is UniswapSingleEthRouter, IFeiRouter {

	IUniswapIncentive public immutable INCENTIVE;

	constructor(
		address pair, 
		address weth,
		address incentive
	) public UniswapSingleEthRouter(pair, weth) {
		INCENTIVE = IUniswapIncentive(incentive);
	}

	

	
}