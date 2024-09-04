// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.6;

import "@yield-protocol/utils-v2/contracts/access/AccessControl.sol";
import "@yield-protocol/utils-v2/contracts/cast/CastBytes32Bytes6.sol";
import "@yield-protocol/utils-v2/contracts/token/IERC20Metadata.sol";
import "@yield-protocol/vault-interfaces/IOracle.sol";
import "../../constants/Constants.sol";
import "./CTokenInterface.sol";


contract CTokenMultiOracle is IOracle, AccessControl, Constants {
    using CastBytes32Bytes6 for bytes32;

    event SourceSet(bytes6 indexed baseId, bytes6 indexed quoteId, CTokenInterface indexed cToken);

    struct Source {
        CTokenInterface source;
        uint8 baseDecimals;
        uint8 quoteDecimals;
        bool inverse;
    }

    mapping(bytes6 => mapping(bytes6 => Source)) public sources;

    /// @dev Set or reset an oracle source and its inverse
    function setSource(bytes6 cTokenId, bytes6 underlyingId, CTokenInterface cToken)
        external auth
    {
        IERC20Metadata underlying = IERC20Metadata(cToken.underlying());
        uint8 underlyingDecimals = underlying.decimals();
        uint8 cTokenDecimals = underlyingDecimals + 10; // https://compound.finance/docs/ctokens#exchange-rate
        sources[cTokenId][underlyingId] = Source({
            source: cToken,
            baseDecimals: cTokenDecimals,
            quoteDecimals: underlyingDecimals,
            inverse: false
        });
        emit SourceSet(cTokenId, underlyingId, cToken);

        sources[underlyingId][cTokenId] = Source({
            source: cToken,
            baseDecimals: underlyingDecimals, // We are reversing the base and the quote
            quoteDecimals: cTokenDecimals,
            inverse: true
        });
        emit SourceSet(underlyingId, cTokenId, cToken);
    }

    /**
     * @notice Retrieve the value of the amount at the latest oracle price.
     */
    

    /**
     * @notice Retrieve the value of the amount at the latest oracle price. Updates the price before fetching it if possible.
     */
    
}