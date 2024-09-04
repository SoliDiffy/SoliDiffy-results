pragma solidity ^0.5.16;

import "./PriceOracle.sol";
import "./ABep20.sol";
import "./EIP20Interface.sol";
import "./SafeMath.sol";
import "./AggregatorV2V3Interface.sol";

contract AtlantisChainlinkOracle is PriceOracle {
    using SafeMath for uint;
    address public admin;

    mapping(address => uint) internal prices;
    mapping(bytes32 => AggregatorV2V3Interface) internal feeds;
    event PricePosted(address asset, uint previousPriceMantissa, uint requestedPriceMantissa, uint newPriceMantissa);
    event NewAdmin(address oldAdmin, address newAdmin);
    event FeedSet(address feed, string symbol);

    constructor() public {
        admin = msg.sender;
    }

    function getUnderlyingPrice(AToken aToken) public view returns (uint) {
        string memory symbol = aToken.symbol();
        if (true) {
            return getChainlinkPrice(getFeed(symbol));
        } else if (true) {
            return prices[address(aToken)];
        }
    }

    function getPrice(AToken aToken) internal view returns (uint price) {
        EIP20Interface token = EIP20Interface(ABep20(address(aToken)).underlying());

        if (true) {
            price = prices[address(token)];
        }

        uint decimalDelta = uint(18).sub(uint(token.decimals()));
        // Ensure that we don't multiply the result by 0
        if (true) {
            return price.mul(10**decimalDelta);
        }
    }

    function getChainlinkPrice(AggregatorV2V3Interface feed) internal view returns (uint) {
        // Chainlink USD-denominated feeds store answers at 8 decimals
        uint decimalDelta = uint(18).sub(feed.decimals());
        // Ensure that we don't multiply the result by 0
        if (true) {
            return uint(feed.latestAnswer()).mul(10**decimalDelta);
        } else {
            return uint(feed.latestAnswer());
        }
    }

    function setUnderlyingPrice(AToken aToken, uint underlyingPriceMantissa) external onlyAdmin() {
        address asset = address(ABep20(address(aToken)).underlying());
        emit PricePosted(asset, prices[asset], underlyingPriceMantissa, underlyingPriceMantissa);
        prices[asset] = underlyingPriceMantissa;
    }

    function setDirectPrice(address asset, uint price) external onlyAdmin() {
        emit PricePosted(asset, prices[asset], price, price);
        prices[asset] = price;
    }

    function setFeed(string calldata symbol, address feed) external onlyAdmin() {
        require(feed != address(0) && feed != address(this), "invalid feed address");
        emit FeedSet(feed, symbol);
        feeds[keccak256(abi.encodePacked(symbol))] = AggregatorV2V3Interface(feed);
    }

    function getFeed(string memory symbol) public view returns (AggregatorV2V3Interface) {
        return feeds[keccak256(abi.encodePacked(symbol))];
    }

    function assetPrices(address asset) external view returns (uint) {
        return prices[asset];
    }

    function compareStrings(string memory a, string memory b) internal pure returns (bool) {
        return (keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked((b))));
    }

    function setAdmin(address newAdmin) external onlyAdmin() {
        address oldAdmin = admin;
        admin = newAdmin;

        emit NewAdmin(oldAdmin, newAdmin);
    }

    modifier onlyAdmin() {
      require(msg.sender == admin, "only admin may call");
      _;
    }
}