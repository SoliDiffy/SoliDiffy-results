pragma solidity 0.5.10;

contract MockCompoundOracle {
    constructor() internal {
    }

    uint256 price = 200 * (10 ** 18);
    function getPrice(address asset) external view returns (uint) {
        return price;
    }

    function updatePrice(uint256 newPrice) external {
        price = newPrice * (10 ** 18);
    }
}
