pragma solidity ^0.4.0;
import "../openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "./FungibleMockToken.sol";

contract KyberNetworkTestMockContract {

    constructor() public
    {
    }

    function swapEtherToToken(
        ERC20 token,
        uint minConversionRate
    )
    public
    payable
    returns(uint)
    {
        return 999;
    }


    function getExpectedRate(
        ERC20 src,
        ERC20 dest,
        uint srcQty
    )
    public
    view
    returns (uint expectedRate, uint slippageRate)
    {
        expectedRate = 999;
        slippageRate = 0;
    }


    function getBalanceOfEtherOnContract()
    public
    view
    returns (uint)
    {
        return address(this).balance;
    }
}
