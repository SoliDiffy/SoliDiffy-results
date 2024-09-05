pragma solidity ^0.6.0;

import "@uniswap/v2-periphery/contracts/libraries/UniswapV2Library.sol";
import "@uniswap/v2-periphery/contracts/interfaces/IWETH.sol";
import "@uniswap/lib/contracts/libraries/TransferHelper.sol";
import "./IUniswapSingleEthRouter.sol";

contract UniswapSingleEthRouter is IUniswapSingleEthRouter {
	IWETH public immutable WETH;
	IUniswapV2Pair public immutable PAIR;

	constructor(
		address pair, 
		address weth
	) public {
        PAIR = IUniswapV2Pair(pair);
		WETH = IWETH(weth);
	}

    receive() external payable {
        // SWC-110-Assert Violation: L22
        assert(msg.sender == address(WETH)); // only accept ETH via fallback from the WETH contract
    }

    modifier ensure(uint deadline) {
        require(deadline >= block.timestamp, 'UniswapSingleEthRouter: EXPIRED');
        _;
    }

    function _getReserves() internal view returns(uint reservesETH, uint reservesOther, bool isETH0) {
        (uint reserves0, uint reserves1, ) = PAIR.getReserves();
        isETH0 = PAIR.token0() == address(WETH);
        return isETH0 ? (reserves0, reserves1, isETH0) : (reserves1, reserves0, isETH0);
    }

    

	
}