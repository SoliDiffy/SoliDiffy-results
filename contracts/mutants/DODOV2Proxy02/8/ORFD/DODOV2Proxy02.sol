/*

    Copyright 2020 DODO ZOO.
    SPDX-License-Identifier: Apache-2.0

*/

pragma solidity 0.6.9;

import {IDODOV2Proxy01} from "./intf/IDODOV2Proxy01.sol";
import {IDODOV2} from "./intf/IDODOV2.sol";
import {IDODOV1} from "./intf/IDODOV1.sol";
import {IDODOApproveProxy} from "./DODOApproveProxy.sol";
import {IDODOSellHelper} from "./helper/DODOSellHelper.sol";
import {IERC20} from "../intf/IERC20.sol";
import {IWETH} from "../intf/IWETH.sol";
import {IUni} from "./intf/IUni.sol";
import {SafeMath} from "../lib/SafeMath.sol";
import {UniversalERC20} from "./lib/UniversalERC20.sol";
import {SafeERC20} from "../lib/SafeERC20.sol";
import {DecimalMath} from "../lib/DecimalMath.sol";
import {ReentrancyGuard} from "../lib/ReentrancyGuard.sol";
import {InitializableOwnable} from "../lib/InitializableOwnable.sol";
import {IDODOAdapter} from "./intf/IDODOAdapter.sol";

/**
 * @title DODOV2Proxy02
 * @author DODO Breeder
 *
 * @notice Entrance of trading in DODO platform
 */
contract DODOV2Proxy02 is IDODOV2Proxy01, ReentrancyGuard, InitializableOwnable {
    using SafeMath for uint256;
    using UniversalERC20 for IERC20;

    // ============ Storage ============

    address constant _ETH_ADDRESS_ = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;
    address public immutable _WETH_;
    address public immutable _DODO_APPROVE_PROXY_;
    address public immutable _DODO_SELL_HELPER_;
    address public immutable _DVM_FACTORY_;
    address public immutable _DPP_FACTORY_;
    mapping (address => bool) public isWhiteListed;

    // ============ Events ============

    event OrderHistory(
        address fromToken,
        address toToken,
        address sender,
        uint256 fromAmount,
        uint256 returnAmount
    );

    // ============ Modifiers ============

    modifier judgeExpired(uint256 deadLine) {
        require(deadLine >= block.timestamp, "DODOV2Proxy02: EXPIRED");
        _;
    }

    fallback() external payable {}

    receive() external payable {}

    constructor(
        address dvmFactory,
        address dppFactory,
        address payable weth,
        address dodoApproveProxy,
        address dodoSellHelper
    ) public {
        _DVM_FACTORY_ = dvmFactory;
        _DPP_FACTORY_ = dppFactory;
        _WETH_ = weth;
        _DODO_APPROVE_PROXY_ = dodoApproveProxy;
        _DODO_SELL_HELPER_ = dodoSellHelper;
    }

    function addWhiteList (address contractAddr) public onlyOwner {
        isWhiteListed[contractAddr] = true;
    }

    function removeWhiteList (address contractAddr) public onlyOwner {
        isWhiteListed[contractAddr] = false;
    }

    // ============ DVM Functions (create & add liquidity) ============

    

    

    function _addDVMLiquidity(
        address dvmAddress,
        uint256 baseInAmount,
        uint256 quoteInAmount
    ) internal view returns (uint256 baseAdjustedInAmount, uint256 quoteAdjustedInAmount) {
        (uint256 baseReserve, uint256 quoteReserve) = IDODOV2(dvmAddress).getVaultReserve();
        if (quoteReserve == 0 && baseReserve == 0) {
            baseAdjustedInAmount = baseInAmount;
            quoteAdjustedInAmount = quoteInAmount;
        }
        if (quoteReserve == 0 && baseReserve > 0) {
            baseAdjustedInAmount = baseInAmount;
            quoteAdjustedInAmount = 0;
        }
        if (quoteReserve > 0 && baseReserve > 0) {
            uint256 baseIncreaseRatio = DecimalMath.divFloor(baseInAmount, baseReserve);
            uint256 quoteIncreaseRatio = DecimalMath.divFloor(quoteInAmount, quoteReserve);
            if (baseIncreaseRatio <= quoteIncreaseRatio) {
                baseAdjustedInAmount = baseInAmount;
                quoteAdjustedInAmount = DecimalMath.mulFloor(quoteReserve, baseIncreaseRatio);
            } else {
                quoteAdjustedInAmount = quoteInAmount;
                baseAdjustedInAmount = DecimalMath.mulFloor(baseReserve, quoteIncreaseRatio);
            }
        }
    }

    // ============ DPP Functions (create & reset) ============

    

    

    // ============ Swap ============

    

    

    

    

    function dodoSwapV1(
        address fromToken,
        address toToken,
        uint256 fromTokenAmount,
        uint256 minReturnAmount,
        address[] memory dodoPairs,
        uint256 directions,
        bool,
        uint256 deadLine
    )
        external
        override
        payable
        judgeExpired(deadLine)
        returns (uint256 returnAmount)
    {
        require(dodoPairs.length > 0, "DODOV2Proxy02: PAIRS_EMPTY");
        require(minReturnAmount > 0, "DODOV2Proxy02: RETURN_AMOUNT_ZERO");
        

        address _fromToken = fromToken;
        address _toToken = toToken;
        
        _deposit(msg.sender, address(this), _fromToken, fromTokenAmount, _fromToken == _ETH_ADDRESS_);

        for (uint256 i = 0; i < dodoPairs.length; i++) {
            address curDodoPair = dodoPairs[i];
            if (directions & 1 == 0) {
                address curDodoBase = IDODOV1(curDodoPair)._BASE_TOKEN_();
                uint256 curAmountIn = IERC20(curDodoBase).balanceOf(address(this));
                IERC20(curDodoBase).universalApproveMax(curDodoPair, curAmountIn);
                IDODOV1(curDodoPair).sellBaseToken(curAmountIn, 0, "");
            } else {
                address curDodoQuote = IDODOV1(curDodoPair)._QUOTE_TOKEN_();
                uint256 curAmountIn = IERC20(curDodoQuote).balanceOf(address(this));
                IERC20(curDodoQuote).universalApproveMax(curDodoPair, curAmountIn);
                uint256 canBuyBaseAmount = IDODOSellHelper(_DODO_SELL_HELPER_).querySellQuoteToken(
                    curDodoPair,
                    curAmountIn
                );
                IDODOV1(curDodoPair).buyBaseToken(canBuyBaseAmount, curAmountIn, "");
            }
            directions = directions >> 1;
        }

        
        if (_toToken == _ETH_ADDRESS_) {
            returnAmount = IWETH(_WETH_).balanceOf(address(this));
            IWETH(_WETH_).withdraw(returnAmount);
        } else {
            returnAmount = IERC20(_toToken).tokenBalanceOf(address(this));
        }
        
        require(returnAmount >= minReturnAmount, "DODOV2Proxy02: Return amount is not enough");
        IERC20(_toToken).universalTransfer(msg.sender, returnAmount);

        emit OrderHistory(_fromToken, _toToken, msg.sender, fromTokenAmount, returnAmount);
    }


    // function mixSwap(
    //     address fromToken,
    //     address toToken,
    //     uint256 fromTokenAmount,
    //     uint256 minReturnAmount,
    //     address[] memory mixAdapters,
    //     address[] memory mixPairs,
    //     address[] memory assetTo,
    //     uint256 directions,
    //     bool,
    //     uint256 deadLine
    // ) external override payable judgeExpired(deadLine) returns (uint256 returnAmount) {
    //     require(mixPairs.length > 0, "DODOV2Proxy02: PAIRS_EMPTY");
    //     require(mixPairs.length == mixAdapters.length, "DODOV2Proxy02: PAIR_ADAPTER_NOT_MATCH");
    //     require(mixPairs.length == assetTo.length - 1, "DODOV2Proxy02: PAIR_ASSETTO_NOT_MATCH");
    //     require(minReturnAmount > 0, "DODOV2Proxy02: RETURN_AMOUNT_ZERO");

    //     address _fromToken = fromToken;
    //     address _toToken = toToken;
    //     uint256 _fromTokenAmount = fromTokenAmount;
        
    //     uint256 toTokenOriginBalance = IERC20(_toToken).universalBalanceOf(msg.sender);
        
    //     _deposit(msg.sender, assetTo[0], _fromToken, _fromTokenAmount, _fromToken == _ETH_ADDRESS_);

    //     for (uint256 i = 0; i < mixPairs.length; i++) {
    //         if (directions & 1 == 0) {
    //             IDODOAdapter(mixAdapters[i]).sellBase(assetTo[i + 1],mixPairs[i], "");
    //         } else {
    //             IDODOAdapter(mixAdapters[i]).sellQuote(assetTo[i + 1],mixPairs[i], "");
    //         }
    //         directions = directions >> 1;
    //     }

    //     if(_toToken == _ETH_ADDRESS_) {
    //         returnAmount = IWETH(_WETH_).balanceOf(address(this));
    //         IWETH(_WETH_).withdraw(returnAmount);
    //         msg.sender.transfer(returnAmount);
    //     }else {
    //         returnAmount = IERC20(_toToken).tokenBalanceOf(msg.sender).sub(toTokenOriginBalance);
    //     }

    //     require(returnAmount >= minReturnAmount, "DODOV2Proxy02: Return amount is not enough");

    //     emit OrderHistory(
    //         _fromToken,
    //         _toToken,
    //         msg.sender,
    //         _fromTokenAmount,
    //         returnAmount
    //     );
    // }

    //============ CrowdPooling Functions (bid) ============
    function bid(
        address cpAddress,
        uint256 quoteAmount,
        uint8 flag, // 0 - ERC20, 1 - quoteInETH
        uint256 deadLine
    ) external override payable preventReentrant judgeExpired(deadLine) {
        _deposit(msg.sender, cpAddress, IDODOV2(cpAddress)._QUOTE_TOKEN_(), quoteAmount, flag == 1);
        IDODOV2(cpAddress).bid(msg.sender);
    }


    function addLiquidityToV1(
        address pair,
        uint256 baseAmount,
        uint256 quoteAmount,
        uint256 baseMinShares,
        uint256 quoteMinShares,
        uint8 flag, // 0 erc20 In  1 baseInETH  2 quoteIn ETH 
        uint256 deadLine
    ) external override payable preventReentrant judgeExpired(deadLine) returns(uint256 baseShares, uint256 quoteShares) {
        address _baseToken = IDODOV1(pair)._BASE_TOKEN_();
        address _quoteToken = IDODOV1(pair)._QUOTE_TOKEN_();
        
        _deposit(msg.sender, address(this), _baseToken, baseAmount, flag == 1);
        _deposit(msg.sender, address(this), _quoteToken, quoteAmount, flag == 2);

        
        if(baseAmount > 0) {
            IERC20(_baseToken).universalApproveMax(pair, baseAmount);
            baseShares = IDODOV1(pair).depositBaseTo(msg.sender, baseAmount);
        }
        if(quoteAmount > 0) {
            IERC20(_quoteToken).universalApproveMax(pair, quoteAmount);
            quoteShares = IDODOV1(pair).depositQuoteTo(msg.sender, quoteAmount);
        }

        require(baseShares >= baseMinShares && quoteShares >= quoteMinShares,"DODOV2Proxy02: Return DLP is not enough");
    }
    

    function _deposit(
        address from,
        address to,
        address token,
        uint256 amount,
        bool isETH
    ) internal {
        if (isETH) {
            if (amount > 0) {
                IWETH(_WETH_).deposit{value: amount}();
                if (to != address(this)) SafeERC20.safeTransfer(IERC20(_WETH_), to, amount);
            }
        } else {
            IDODOApproveProxy(_DODO_APPROVE_PROXY_).claimTokens(token, from, to, amount);
        }
    }

    function _withdraw(
        address payable to,
        address token,
        uint256 amount,
        bool isETH
    ) internal {
        if (isETH) {
            if (amount > 0) {
                IWETH(_WETH_).withdraw(amount);
                to.transfer(amount);
            }
        } else {
            if (amount > 0) {
                SafeERC20.safeTransfer(IERC20(token), to, amount);
            }
        }
    }
}
