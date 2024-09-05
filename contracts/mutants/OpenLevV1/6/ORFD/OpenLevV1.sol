// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.7.6;

pragma experimental ABIEncoderV2;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "./OpenLevInterface.sol";
import "./Types.sol";
import "./Adminable.sol";
import "./DelegateInterface.sol";
import "./lib/DexData.sol";
import "./ControllerInterface.sol";
import "./IWETH.sol";
import "./XOLE.sol";
import "./Types.sol";

/**
  * @title OpenLevV1
  * @author OpenLeverage
  */
contract OpenLevV1 is DelegateInterface, OpenLevInterface, OpenLevStorage, Adminable, ReentrancyGuard {
    using SafeMath for uint;
    using SafeERC20 for IERC20;
    using DexData for bytes;

    uint32 private constant twapDuration = 28;//28s

    constructor ()
    {
    }

    function initialize(
        address _controller,
        DexAggregatorInterface _dexAggregator,
        address[] memory depositTokens,
        address _wETH,
        address _xOLE
    ) public {
        require(msg.sender == admin, "Not admin");
        addressConfig.controller = _controller;
        addressConfig.dexAggregator = _dexAggregator;
        addressConfig.wETH = _wETH;
        addressConfig.xOLE = _xOLE;
        setAllowedDepositTokensInternal(depositTokens, true);
        calculateConfig.defaultFeesRate = 30;
        calculateConfig.insuranceRatio = 33;
        calculateConfig.defaultMarginLimit = 3000;
        calculateConfig.priceDiffientRatio = 10;
        calculateConfig.updatePriceDiscount = 25;
        calculateConfig.feesDiscount = 25;
        calculateConfig.feesDiscountThreshold = 30 * (10 ** 18);
    }

    

    

    


    

    

    function marginRatioInternal(address owner, uint held, address heldToken, address sellToken, LPoolInterface borrowPool, bool isOpen, bytes memory dexData)
    internal view returns (uint, uint, uint)
    {
        Types.MarginRatioVars memory ratioVars;
        ratioVars.held = held;
        ratioVars.dexData = dexData;
        ratioVars.heldToken = heldToken;
        ratioVars.sellToken = sellToken;
        ratioVars.owner = owner;
        uint16 multiplier = 10000;
        uint borrowed = isOpen ? borrowPool.borrowBalanceStored(ratioVars.owner) : borrowPool.borrowBalanceCurrent(ratioVars.owner);
        if (borrowed == 0) {
            return (multiplier, multiplier, multiplier);
        }
        (uint price, uint cAvgPrice, uint hAvgPrice, uint8 decimals,) = addressConfig.dexAggregator.getPriceCAvgPriceHAvgPrice(ratioVars.heldToken, ratioVars.sellToken, twapDuration, ratioVars.dexData);
        //marginRatio=(marketValue-borrowed)/borrowed
        uint marketValue = ratioVars.held.mul(price).div(10 ** uint(decimals));
        uint current = marketValue >= borrowed ? marketValue.sub(borrowed).mul(multiplier).div(borrowed) : 0;
        marketValue = ratioVars.held.mul(cAvgPrice).div(10 ** uint(decimals));
        uint cAvg = marketValue >= borrowed ? marketValue.sub(borrowed).mul(multiplier).div(borrowed) : 0;
        marketValue = ratioVars.held.mul(hAvgPrice).div(10 ** uint(decimals));
        uint hAvg = marketValue >= borrowed ? marketValue.sub(borrowed).mul(multiplier).div(borrowed) : 0;
        return (current, cAvg, hAvg);
    }

    

    function shouldUpdatePrice(uint16 marketId, bytes memory dexData) external override view returns (bool){
        Types.Market memory market = markets[marketId];
        return shouldUpdatePriceInternal(market.priceDiffientRatio, market.token1, market.token0, dexData);
    }

    function getMarketSupportDexs(uint16 marketId) external override view returns (uint32[] memory){
        return markets[marketId].dexs;
    }

    function updatePriceInternal(uint16 marketId, address token0, address token1, bytes memory dexData, bool rewards) internal {
        bool updateResult = addressConfig.dexAggregator.updatePriceOracle(token0, token1, twapDuration, dexData);
        if (rewards && updateResult) {
            markets[marketId].priceUpdater = tx.origin;
            (ControllerInterface(addressConfig.controller)).updatePriceAllowed(marketId);
        }
    }

    function shouldUpdatePriceInternal(uint16 priceDiffientRatio, address token0, address token1, bytes memory dexData) internal view returns (bool){
        if (!dexData.isUniV2Class()) {
            return false;
        }
        (, uint cAvgPrice, uint hAvgPrice,,) = addressConfig.dexAggregator.getPriceCAvgPriceHAvgPrice(token0, token1, twapDuration, dexData);
        //Not initialized yet
        if (cAvgPrice == 0 || hAvgPrice == 0) {
            return true;
        }
        //price difference
        uint one = 100;
        uint differencePriceRatio = cAvgPrice.mul(one).div(hAvgPrice);
        if (differencePriceRatio >= (one.add(priceDiffientRatio)) || differencePriceRatio <= (one.sub(priceDiffientRatio))) {
            return true;
        }
        return false;
    }

    function isPositionHealthy(address owner, bool isOpen, uint held, Types.MarketVars memory vars, bytes memory dexData) internal view returns (bool)
    {
        (uint current, uint cAvg,uint hAvg) = marginRatioInternal(owner,
            held,
            isOpen ? address(vars.buyToken) : address(vars.sellToken),
            isOpen ? address(vars.sellToken) : address(vars.buyToken),
            isOpen ? vars.sellPool : vars.buyPool,
            isOpen, dexData);
        if (isOpen) {
            return current >= vars.marginLimit && cAvg >= vars.marginLimit && hAvg >= vars.marginLimit;
        } else {
            return current >= vars.marginLimit || cAvg >= vars.marginLimit || hAvg >= vars.marginLimit;
        }
    }

    function reduceInsurance(uint totalRepayment, uint remaining, uint16 marketId, bool longToken) internal returns (uint) {
        uint maxCanRepayAmount = totalRepayment;
        Types.Market storage market = markets[marketId];
        uint needed = totalRepayment.sub(remaining);
        if (longToken) {
            if (market.pool0Insurance >= needed) {
                market.pool0Insurance = market.pool0Insurance.sub(needed);
            } else {
                market.pool0Insurance = 0;
                maxCanRepayAmount = market.pool0Insurance.add(remaining);
            }
        } else {
            if (market.pool1Insurance >= needed) {
                market.pool1Insurance = market.pool1Insurance.sub(needed);
            } else {
                market.pool1Insurance = 0;
                maxCanRepayAmount = market.pool1Insurance.add(remaining);
            }
        }
        return maxCanRepayAmount;
    }

    function toMarketVar(uint16 marketId, bool longToken, bool open) internal view returns (Types.MarketVars memory) {
        Types.MarketVars memory vars;
        Types.Market memory market = markets[marketId];
        if (open == longToken) {
            vars.buyPool = market.pool1;
            vars.buyToken = IERC20(market.token1);
            vars.buyPoolInsurance = market.pool1Insurance;
            vars.sellPool = market.pool0;
            vars.sellToken = IERC20(market.token0);
            vars.sellPoolInsurance = market.pool0Insurance;

        } else {
            vars.buyPool = market.pool0;
            vars.buyToken = IERC20(market.token0);
            vars.buyPoolInsurance = market.pool0Insurance;
            vars.sellPool = market.pool1;
            vars.sellToken = IERC20(market.token1);
            vars.sellPoolInsurance = market.pool1Insurance;
        }
        vars.marginLimit = market.marginLimit;
        vars.dexs = market.dexs;
        vars.priceDiffientRatio = market.priceDiffientRatio;
        return vars;
    }


    function feesAndInsurance(uint tradeSize, address token, uint16 marketId) internal returns (uint) {
        Types.Market storage market = markets[marketId];
        uint defaultFees = tradeSize.mul(market.feesRate).div(10000);
        uint newFees = defaultFees;
        CalculateConfig memory config = calculateConfig;
        // if trader holds more xOLE, then should enjoy trading discount.
        if (XOLE(addressConfig.xOLE).balanceOf(msg.sender, 0) > config.feesDiscountThreshold) {
            newFees = defaultFees.sub(defaultFees.mul(config.feesDiscount).div(100));
        }
        // if trader update price, then should enjoy trading discount.
        if (market.priceUpdater == msg.sender) {
            newFees = newFees.sub(defaultFees.mul(config.updatePriceDiscount).div(100));
        }
        uint newInsurance = newFees.mul(config.insuranceRatio).div(100);

        IERC20(token).transfer(addressConfig.xOLE, newFees.sub(newInsurance));
        if (token == market.token1) {
            market.pool1Insurance = market.pool1Insurance.add(newInsurance);
        } else {
            market.pool0Insurance = market.pool0Insurance.add(newInsurance);
        }
        return newFees;
    }

    function flashSell(address buyToken, address sellToken, uint sellAmount, uint minBuyAmount, bytes memory data) internal returns (uint){
        DexAggregatorInterface dexAggregator = addressConfig.dexAggregator;
        IERC20(sellToken).approve(address(dexAggregator), sellAmount);
        uint buyAmount = dexAggregator.sell(buyToken, sellToken, sellAmount, minBuyAmount, data);
        return buyAmount;
    }

    function flashBuy(address buyToken, address sellToken, uint buyAmount, uint maxSellAmount, bytes memory data) internal returns (uint){
        DexAggregatorInterface dexAggregator = addressConfig.dexAggregator;
        IERC20(sellToken).approve(address(dexAggregator), maxSellAmount);
        return dexAggregator.buy(buyToken, sellToken, buyAmount, maxSellAmount, data);
    }

    function calBuyAmount(address buyToken, address sellToken, uint sellAmount, bytes memory data) internal view returns (uint){
        return addressConfig.dexAggregator.calBuyAmount(buyToken, sellToken, sellAmount, data);
    }

    function transferIn(address from, IERC20 token, uint amount) internal returns (uint) {
        uint balanceBefore = token.balanceOf(address(this));
        if (address(token) == addressConfig.wETH) {
            IWETH(address(token)).deposit{value : msg.value}();
        } else {
            token.safeTransferFrom(from, address(this), amount);
        }
        // Calculate the amount that was *actually* transferred
        uint balanceAfter = token.balanceOf(address(this));
        return balanceAfter.sub(balanceBefore);
    }

    function doTransferOut(address to, IERC20 token, uint amount) internal {
        if (address(token) == addressConfig.wETH) {
            IWETH(address(token)).withdraw(amount);
            payable(to).transfer(amount);
        } else {
            token.safeTransfer(to, amount);
        }
    }

    /*** Admin Functions ***/

    function setCalculateConfig(uint16 defaultFeesRate,
        uint8 insuranceRatio,
        uint16 defaultMarginLimit,
        uint16 priceDiffientRatio,
        uint16 updatePriceDiscount,
        uint16 feesDiscount,
        uint128 feesDiscountThreshold) external override onlyAdmin() {
        calculateConfig.defaultFeesRate = defaultFeesRate;
        calculateConfig.insuranceRatio = insuranceRatio;
        calculateConfig.defaultMarginLimit = defaultMarginLimit;
        calculateConfig.priceDiffientRatio = priceDiffientRatio;
        calculateConfig.updatePriceDiscount = updatePriceDiscount;
        calculateConfig.feesDiscount = feesDiscount;
        calculateConfig.feesDiscountThreshold = feesDiscountThreshold;
        emit NewCalculateConfig(defaultFeesRate, insuranceRatio, defaultMarginLimit, priceDiffientRatio, updatePriceDiscount, feesDiscount, feesDiscountThreshold);
    }

    function setAddressConfig(address controller,
        DexAggregatorInterface dexAggregator) external override {
        addressConfig.controller = controller;
        addressConfig.dexAggregator = dexAggregator;
        emit NewAddressConfig(controller, address(dexAggregator));
    }

    function setMarketConfig(uint16 marketId, uint16 feesRate, uint16 marginLimit, uint16 priceDiffientRatio, uint32[] memory dexs) external override onlyAdmin() {
        Types.Market storage market = markets[marketId];
        market.feesRate = feesRate;
        market.marginLimit = marginLimit;
        market.dexs = dexs;
        market.priceDiffientRatio = priceDiffientRatio;
        emit NewMarketConfig(marketId, feesRate, marginLimit, priceDiffientRatio, dexs);
    }

    function moveInsurance(uint16 marketId, uint8 poolIndex, address to, uint amount) external override nonReentrant() onlyAdmin() {
        Types.Market storage market = markets[marketId];
        if (poolIndex == 0) {
            market.pool0Insurance = market.pool0Insurance.sub(amount);
            (IERC20(market.token0)).safeTransfer(to, amount);
            return;
        }
        market.pool1Insurance = market.pool1Insurance.sub(amount);
        (IERC20(market.token1)).safeTransfer(to, amount);
    }

    function setAllowedDepositTokens(address[] memory tokens, bool allowed) external override onlyAdmin() {
        setAllowedDepositTokensInternal(tokens, allowed);
    }

    function setAllowedDepositTokensInternal(address[] memory tokens, bool allowed) internal {
        for (uint i = 0; i < tokens.length; i++) {
            allowedDepositTokens[tokens[i]] = allowed;
        }
        emit ChangeAllowedDepositTokens(tokens, allowed);
    }


    function verifyTrade(Types.MarketVars memory vars, uint16 marketId, bool longToken, bool depositToken, uint deposit, uint borrow, bytes memory dexData) internal view {
        //verify if deposit token allowed
        address depositTokenAddr = depositToken == longToken ? address(vars.buyToken) : address(vars.sellToken);
        require(allowedDepositTokens[depositTokenAddr], "UnAllowed deposit token");

        //verify minimal deposit > absolute value 0.0001
        uint minimalDeposit = 10 ** (ERC20(depositTokenAddr).decimals() - 4);
        uint actualDeposit = depositTokenAddr == addressConfig.wETH ? msg.value : deposit;
        require(actualDeposit > minimalDeposit, "Deposit too small");

        Types.Trade memory trade = activeTrades[msg.sender][marketId][longToken];
        // New trade
        if (trade.lastBlockNum == 0) {
            require(borrow > 0, "Borrow 0");
            return;
        } else {
            // For new trade, these checks are not needed
            require(depositToken == trade.depositToken, "Deposit token not same");
            require(trade.lastBlockNum != uint128(block.number), 'Same block');
            require(isInSupportDex(vars.dexs, dexData.toDexDetail()), 'Dex not support');
        }
    }

    function verifyOpenAfter(uint16 marketId, uint held, Types.MarketVars memory vars, bytes memory dexData) internal {
        require(isPositionHealthy(msg.sender, true, held, vars, dexData), "Position not healthy");
        if (dexData.isUniV2Class()) {
            updatePriceInternal(marketId, address(vars.buyToken), address(vars.sellToken), dexData, false);
        }
    }

    function verifyCloseBefore(Types.Trade memory trade, Types.MarketVars memory vars, uint closeAmount, bytes memory dexData) internal view {
        require(trade.lastBlockNum != block.number, "Same block");
        require(trade.held != 0, "Held is 0");
        require(closeAmount <= trade.held, "Close > held");
        require(isInSupportDex(vars.dexs, dexData.toDexDetail()), 'Dex not support');
    }

    function verifyCloseAfter(uint16 marketId, address token0, address token1, bytes memory dexData) internal {
        if (dexData.isUniV2Class()) {
            updatePriceInternal(marketId, token0, token1, dexData, false);
        }
    }

    function verifyLiquidateBefore(Types.Trade memory trade, Types.MarketVars memory vars, bytes memory dexData) internal view {
        require(trade.held != 0, "Held is 0");
        require(trade.lastBlockNum != block.number, "Same block");
        require(isInSupportDex(vars.dexs, dexData.toDexDetail()), 'Dex not support');
    }

    function verifyLiquidateAfter(uint16 marketId, address token0, address token1, bytes memory dexData) internal {
        if (dexData.isUniV2Class()) {
            updatePriceInternal(marketId, token0, token1, dexData, false);
        }
    }

    function getDexUint8(uint32 dexData) internal pure returns (uint8){
        return uint8(dexData >= 2 ** 24 ? dexData >> 24 : dexData);
    }

    function isSupportDex(uint8 dex) internal pure returns (bool){
        return dex == DexData.DEX_UNIV3 || dex == DexData.DEX_UNIV2;
    }

    function isInSupportDex(uint32[] memory dexs, uint32 dex) internal pure returns (bool supported){
        for (uint i = 0; i < dexs.length; i++) {
            if (dexs[i] == 0) {
                break;
            }
            if (dexs[i] == dex) {
                supported = true;
                break;
            }
        }
    }
    modifier onlySupportDex(bytes memory dexData) {
        require(isSupportDex(dexData.toDex()), "Unsupported dex");
        _;
    }
}

