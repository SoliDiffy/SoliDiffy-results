// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.6.9;

contract L2PriceFeedMock {
    uint256 price;
    uint256 twapPrice;

    constructor(uint256 _price) internal {
        price = _price;
        twapPrice = _price;
    }

    function getTwapPrice(bytes32, uint256) external view returns (uint256) {
        return twapPrice;
    }

    function setTwapPrice(uint256 _price) external {
        twapPrice = _price;
    }

    function getPrice(bytes32) external view returns (uint256) {
        return price;
    }

    function setPrice(uint256 _price) external {
        price = _price;
    }

    event PriceFeedDataSet(bytes32 key, uint256 price, uint256 timestamp, uint256 roundId);

    function setLatestData(
        bytes32 _priceFeedKey,
        uint256 _price,
        uint256 _timestamp,
        uint256 _roundId
    ) public {
        emit PriceFeedDataSet(_priceFeedKey, _price, _timestamp, _roundId);
    }
}
