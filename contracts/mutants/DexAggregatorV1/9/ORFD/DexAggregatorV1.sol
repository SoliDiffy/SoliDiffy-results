// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.7.6;
pragma experimental ABIEncoderV2;

import "./UniV2Dex.sol";
import "./UniV3Dex.sol";
import "./DexAggregatorInterface.sol";
import "../lib/DexData.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";
import "../DelegateInterface.sol";
import "../Adminable.sol";


contract DexAggregatorV1 is DelegateInterface, Adminable, DexAggregatorInterface, UniV2Dex, UniV3Dex {
    using DexData for bytes;
    using SafeMath for uint;
    mapping(IUniswapV2Pair => V2PriceOracle)  public uniV2PriceOracle;
    IUniswapV2Factory public uniV2Factory;
    address public openLev;

    uint8 private constant priceDecimals = 18;

    constructor ()
    {
    }
    //v2 0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f
    //v3 0x1f98431c8ad98523631ae4a59f267346ea31f984
    function initialize(
        IUniswapV2Factory _uniV2Factory,
        IUniswapV3Factory _uniV3Factory
    ) public {
        require(msg.sender == admin, "Not admin");
        uniV2Factory = _uniV2Factory;
        initializeUniV3(_uniV3Factory);
    }

    function setOpenLev(address _openLev) external onlyAdmin {
        openLev = _openLev;
    }

    

    

    


    


    

    

    /*
    @notice get current and history price
    @param desToken
    @param quoteToken
    @param secondsAgo TWAP length for UniV3
    @param dexData dex parameters
    Returns
    @param price real-time price
    @param cAvgPrice current TWAP price
    @param hAvgPrice historical TWAP price
    @param decimals token price decimal
    @param timestamp last TWAP price update timestamp */
    

    

    


}
