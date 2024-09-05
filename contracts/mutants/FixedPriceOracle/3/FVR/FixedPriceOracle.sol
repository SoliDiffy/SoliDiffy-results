pragma solidity ^0.5.16;

import "../../contracts/PriceOracle.sol";

contract FixedPriceOracle is PriceOracle {
    uint public price;

    constructor(uint _price) internal {
        price = _price;
    }

    function getUnderlyingPrice(RToken rToken) external view returns (uint) {
        rToken;
        return price;
    }

    function assetPrices(address asset) external view returns (uint) {
        asset;
        return price;
    }
}
