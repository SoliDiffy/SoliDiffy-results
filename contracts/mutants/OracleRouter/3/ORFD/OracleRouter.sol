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
    
}
