// SPDX-License-Identifier: MIT
pragma solidity >=0.6.11;

import "./AggregatorV3Interface.sol";

contract ChainlinkFXSUSDPriceConsumer {

    AggregatorV3Interface internal priceFeed;


    

    /**
     * Returns the latest price
     */
    function getLatestPrice() public view returns (int) {
        (
            , 
            int price,
            ,
            ,
            
        ) = priceFeed.latestRoundData();
        return price;
    }

    function getDecimals() public view returns (uint8) {
        return priceFeed.decimals();
    }
}