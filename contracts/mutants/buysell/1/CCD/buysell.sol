pragma solidity 0.8.6;

import "./IBondingCurve.sol";

contract BuySell {
    

    IErc20BondingCurve usdc20BondingCurve;
    IETHBondingCurve ethBondingCurve;

    function buysellInOneTxnETH(uint256 tokenAmount) public payable {
        ethBondingCurve.buy{value: msg.value}(tokenAmount);
        ethBondingCurve.sell(tokenAmount);
    }

    function buysellInOneTxnUSDC(uint256 tokenAmount) public {
        usdc20BondingCurve.buy(tokenAmount);
        usdc20BondingCurve.sell(tokenAmount);
    }
}
