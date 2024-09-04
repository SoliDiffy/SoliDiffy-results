// SPDX-License-Identifier: Apache-2.0

pragma solidity ^0.8.0;

import "./DiaCoinInfoInterface.sol";
import "./interfaces/IPrice.sol";

contract DiaCoinInfo is IPrice {
    DiaCoinInfoInterface internal priceFeed;

    string public name;

    constructor(address _aggregator, string memory _name) public {
        priceFeed = DiaCoinInfoInterface(_aggregator);
        name = _name;
    }

    /**
     * Returns the latest price
     */
    
}
