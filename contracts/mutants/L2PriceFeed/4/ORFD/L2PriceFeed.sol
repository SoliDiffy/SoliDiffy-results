// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.6.9;

import { IAMB } from "./bridge/external/IAMB.sol";
import { SafeMath } from "@openzeppelin/contracts-ethereum-package/contracts/math/SafeMath.sol";
import { IPriceFeed } from "./interface/IPriceFeed.sol";
import { BlockContext } from "./utils/BlockContext.sol";
import { PerpFiOwnableUpgrade } from "./utils/PerpFiOwnableUpgrade.sol";

contract L2PriceFeed is IPriceFeed, PerpFiOwnableUpgrade, BlockContext {
    using SafeMath for uint256;

    modifier onlyChainlink() {
        require(_msgSender() == chainlinkContract, "!chainlinkContract");
        _;
    }

    event PriceFeedDataSet(bytes32 key, uint256 price, uint256 timestamp, uint256 roundId);

    struct PriceData {
        uint256 roundId;
        uint256 price;
        uint256 timestamp;
    }

    struct PriceFeed {
        bool registered;
        PriceData[] priceData;
    }

    //**********************************************************//
    //    Can not change the order of below state variables     //
    //**********************************************************//

    address public chainlinkContract;

    // key by currency symbol, eg ETH
    mapping(bytes32 => PriceFeed) public priceFeedMap;
    bytes32[] public priceFeedKeys;

    //**********************************************************//
    //    Can not change the order of above state variables     //
    //**********************************************************//

    //◥◤◥◤◥◤◥◤◥◤◥◤◥◤◥◤ add state variables below ◥◤◥◤◥◤◥◤◥◤◥◤◥◤◥◤//

    //◢◣◢◣◢◣◢◣◢◣◢◣◢◣◢◣ add state variables above ◢◣◢◣◢◣◢◣◢◣◢◣◢◣◢◣//
    uint256[50] private __gap;

    //
    // FUNCTIONS
    //
    function initialize() public initializer {
        __Ownable_init();
    }

    function addAggregator(bytes32 _priceFeedKey) external onlyOwner {
        requireKeyExisted(_priceFeedKey, false);
        priceFeedMap[_priceFeedKey].registered = true;
        priceFeedKeys.push(_priceFeedKey);
    }

    function removeAggregator(bytes32 _priceFeedKey) external onlyOwner {
        requireKeyExisted(_priceFeedKey, true);
        delete priceFeedMap[_priceFeedKey];

        uint256 length = priceFeedKeys.length;
        for (uint256 i; i < length; i++) {
            if (priceFeedKeys[i] == _priceFeedKey) {
                priceFeedKeys[i] = priceFeedKeys[length - 1];
                priceFeedKeys.pop();
                break;
            }
        }
    }

    function setChainlink(address _chainlinkContract) external onlyOwner {
        require(_chainlinkContract != address(0), "addr is empty");
        chainlinkContract = _chainlinkContract;
    }

    //
    // INTERFACE IMPLEMENTATION
    //

    

    

    

    

    function getPreviousPrice(bytes32 _priceFeedKey, uint256 _numOfRoundBack) public view override returns (uint256) {
        require(isExistedKey(_priceFeedKey), "key not existed");

        uint256 len = getPriceFeedLength(_priceFeedKey);
        require(len > 0 && _numOfRoundBack < len, "Not enough history");
        return priceFeedMap[_priceFeedKey].priceData[len - _numOfRoundBack - 1].price;
    }

    function getPreviousTimestamp(bytes32 _priceFeedKey, uint256 _numOfRoundBack)
        public
        view
        override
        returns (uint256)
    {
        require(isExistedKey(_priceFeedKey), "key not existed");

        uint256 len = getPriceFeedLength(_priceFeedKey);
        require(len > 0 && _numOfRoundBack < len, "Not enough history");
        return priceFeedMap[_priceFeedKey].priceData[len - _numOfRoundBack - 1].timestamp;
    }

    //
    // END OF INTERFACE IMPLEMENTATION
    //

    // @dev there's no purpose for a registered priceFeed with 0 priceData so it will revert directly
    function getPriceFeedLength(bytes32 _priceFeedKey) public view returns (uint256 length) {
        return priceFeedMap[_priceFeedKey].priceData.length;
    }

    //
    // INTERNAL
    //

    function getLatestRoundId(bytes32 _priceFeedKey) internal view returns (uint256) {
        uint256 len = getPriceFeedLength(_priceFeedKey);
        if (len == 0) {
            return 0;
        }
        return priceFeedMap[_priceFeedKey].priceData[len - 1].roundId;
    }

    function isExistedKey(bytes32 _priceFeedKey) private view returns (bool) {
        return priceFeedMap[_priceFeedKey].registered;
    }

    function requireKeyExisted(bytes32 _key, bool _existed) private view {
        if (_existed) {
            require(isExistedKey(_key), "key not existed");
        } else {
            require(!isExistedKey(_key), "key existed");
        }
    }
}
