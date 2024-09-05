// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.6;

import "../TempusPool.sol";
import "../protocols/lido/ILido.sol";

contract LidoTempusPool is TempusPool {
    ILido internal immutable lido;
    bytes32 public immutable override protocolName = "Lido";
    address private immutable referrer;

    constructor(
        ILido token,
        address controller,
        uint256 maturity,
        uint256 estYield,
        string memory principalName,
        string memory principalSymbol,
        string memory yieldName,
        string memory yieldSymbol,
        address referrerAddress
    )
        TempusPool(
            address(token),
            address(0),
            controller,
            maturity,
            updateInterestRate(address(token)),
            estYield,
            principalName,
            principalSymbol,
            yieldName,
            yieldSymbol
        )
    {
        // TODO: consider adding sanity check for _lido.name() and _lido.symbol()
        lido = token;
        referrer = referrerAddress;
    }

    

    

    /// @return Updated current Interest Rate as an 1e18 decimal
    

    // @return Stored Interest Rate as an 1e18 decimal
    

    /// NOTE: Lido StETH is pegged 1:1 to ETH
    /// @return Asset Token amount
    function numAssetsPerYieldToken(uint yieldTokens, uint) public pure override returns (uint) {
        return yieldTokens;
    }

    /// NOTE: Lido StETH is pegged 1:1 to ETH
    /// @return YBT amount
    function numYieldTokensPerAsset(uint backingTokens, uint) public pure override returns (uint) {
        return backingTokens;
    }
}
