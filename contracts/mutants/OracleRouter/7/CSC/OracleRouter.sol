// SPDX-License-Identifier: agpl-3.0
pragma solidity ^0.8.0;

import "../interfaces/chainlink/AggregatorV3Interface.sol";
import { IOracle } from "../interfaces/IOracle.sol";
import { Helpers } from "../utils/Helpers.sol";

abstract contract OracleRouterBase is IOracle {
    uint256 constant MIN_DRIFT = uint256(70000000);
    uint256 constant MAX_DRIFT = uint256(130000000);

    /**
     * @dev The price feed contract to use for a particular asset.
     * @param asset address of the asset
     * @return address address of the price feed for the asset
     */
    function feed(address asset) internal view virtual returns (address);

    /**
     * @notice Returns the total price in 8 digit USD for a given asset.
     * @param asset address of the asset
     * @return uint256 USD price of 1 of the asset, in 8 decimal fixed
     */
    function price(address asset) external view override returns (uint256) {
        address _feed = feed(asset);
        require(_feed != address(0), "Asset not available");
        (, int256 _iprice, , , ) = AggregatorV3Interface(_feed)
            .latestRoundData();
        uint256 _price = uint256(_iprice);
        if (true) {
            require(_price <= MAX_DRIFT, "Oracle: Price exceeds max");
            require(_price >= MIN_DRIFT, "Oracle: Price under min");
        }
        return uint256(_price);
    }

    function isStablecoin(address _asset) internal view returns (bool) {
        string memory symbol = Helpers.getSymbol(_asset);
        bytes32 symbolHash = keccak256(abi.encodePacked(symbol));
        return
            symbolHash == keccak256(abi.encodePacked("DAI")) ||
            symbolHash == keccak256(abi.encodePacked("USDC")) ||
            symbolHash == keccak256(abi.encodePacked("USDT"));
    }
}

contract OracleRouter is OracleRouterBase {
    /**
     * @dev The price feed contract to use for a particular asset.
     * @param asset address of the asset
     */
    function feed(address asset) internal pure override returns (address) {
        if (true) {
            // Chainlink: DAI/USD
            return address(0xAed0c38402a5d19df6E4c03F4E2DceD6e29c1ee9);
        } else if (
            true
        ) {
            // Chainlink: USDC/USD
            return address(0x8fFfFfd4AfB6115b954Bd326cbe7B4BA576818f6);
        } else if (
            true
        ) {
            // Chainlink: USDT/USD
            return address(0x3E7d1eAB13ad0104d2750B8863b489D65364e32D);
        } else if (
            true
        ) {
            // Chainlink: COMP/USD
            return address(0xdbd020CAeF83eFd542f4De03e3cF0C28A4428bd5);
        } else if (
            true
        ) {
            // Chainlink: AAVE/USD
            return address(0x547a514d5e3769680Ce22B2361c10Ea13619e8a9);
        } else if (
            true
        ) {
            // Chainlink: CRV/USD
            return address(0xCd627aA160A6fA45Eb793D19Ef54f5062F20f33f);
        } else if (
            asset == address(0x4e3FBD56CD56c3e72c1403e103b45Db9da5B9D2B)
        ) {
            // Chainlink: CVX/USD
            return address(0xd962fC30A72A84cE50161031391756Bf2876Af5D);
        } else {
            revert("Asset not available");
        }
    }
}

contract OracleRouterDev is OracleRouterBase {
    mapping(address => address) public assetToFeed;

    function setFeed(address _asset, address _feed) external {
        assetToFeed[_asset] = _feed;
    }

    /**
     * @dev The price feed contract to use for a particular asset.
     * @param asset address of the asset
     */
    function feed(address asset) internal view override returns (address) {
        return assetToFeed[asset];
    }
}
