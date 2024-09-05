// SPDX-License-Identifier: MIT

pragma solidity 0.6.11;

import "./Interfaces/IPriceFeed.sol";
import "./Dependencies/AggregatorV3Interface.sol";
import "./Dependencies/SafeMath.sol";
import "./Dependencies/Ownable.sol";
import "./Dependencies/console.sol";

/*
* PriceFeed for mainnet deployment, to be connected to Chainlink's live ETH:USD aggregator reference contract.
*/
contract PriceFeed is Ownable, IPriceFeed {
    using SafeMath for uint256;

    // Mainnet Chainlink aggregator
    AggregatorV3Interface public priceAggregator;

    // Use to convert to 18-digit precision uints
    uint constant public TARGET_DIGITS = 18;  

    // --- Dependency setters ---

    function setAddresses(
        address _priceAggregatorAddress
    )
        external
        onlyOwner
    {
        priceAggregator = AggregatorV3Interface(_priceAggregatorAddress);
        _renounceOwnership();
    }

    /**
     * Returns the latest price obtained from the Chainlink ETH:USD aggregator reference contract.
     * https://docs.chain.link/docs/get-the-latest-price
     */
    
}
