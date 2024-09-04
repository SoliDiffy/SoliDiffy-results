// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.6;

import "./IChainlinkAggregator.sol";
import "./IENS.sol";
import "../ITokenPairPriceFeed.sol";

abstract contract ChainlinkTokenPairPriceFeed is ITokenPairPriceFeed {
    // The ENS registry (same for mainnet and all major test nets)
    IENS public constant ENS = IENS(0x00000000000C2E074eC69A0dFb2997BA6C7d2e1e);

    
}
