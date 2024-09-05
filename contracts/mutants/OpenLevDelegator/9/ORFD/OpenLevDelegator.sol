// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.7.6;

pragma experimental ABIEncoderV2;

import "@openzeppelin/contracts/token/ERC20/SafeERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./OpenLevInterface.sol";
import "./Types.sol";
import "./Adminable.sol";
import "./DelegatorInterface.sol";
import "./dex/UniV2Dex.sol";


/**
  * @title OpenLevDelegator
  * @author OpenLeverage
  */
contract OpenLevDelegator is DelegatorInterface, OpenLevInterface, OpenLevStorage, Adminable {

    constructor(
        ControllerInterface _controller,
        DexAggregatorInterface _dexAggregator,
        address[] memory _depositTokens,
        address _wETH,
        address _xOLE,
        address payable _admin,
        address implementation_){
        admin = msg.sender;
        // Creator of the contract is admin during initialization
        // First delegate gets to initialize the delegator (i.e. storage contract)
        delegateTo(implementation_, abi.encodeWithSignature("initialize(address,address,address[],address,address)",
            _controller,
            _dexAggregator,
            _depositTokens,
            _wETH,
            _xOLE
            ));
        implementation = implementation_;

        // Set the proper admin now that initialization is done
        admin = _admin;
    }

    /**
     * Called by the admin to update the implementation of the delegator
     * @param implementation_ The address of the new implementation for delegation
     */
    

    

    

    

    

    

    


    

    
    /*** Admin Functions ***/

    function setCalculateConfig(uint16 defaultFeesRate,
        uint8 insuranceRatio,
        uint16 defaultMarginLimit,
        uint16 priceDiffientRatio,
        uint16 updatePriceDiscount,
        uint16 feesDiscount,
        uint128 feesDiscountThreshold) external override {
        delegateToImplementation(abi.encodeWithSignature("setCalculateConfig(uint16,uint8,uint16,uint16,uint16,uint16,uint128)", defaultFeesRate, insuranceRatio, defaultMarginLimit, priceDiffientRatio, updatePriceDiscount, feesDiscount, feesDiscountThreshold));
    }

    function setAddressConfig(address controller,
        DexAggregatorInterface dexAggregator) external override {
        delegateToImplementation(abi.encodeWithSignature("setAddressConfig(address,address)", controller, address(dexAggregator)));
    }

    function setMarketConfig(uint16 marketId, uint16 feesRate, uint16 marginLimit, uint16 priceDiffientRatio, uint32[] memory dexs) external override {
        delegateToImplementation(abi.encodeWithSignature("setMarketConfig(uint16,uint16,uint16,uint16,uint32[])", marketId, feesRate, marginLimit, priceDiffientRatio, dexs));
    }

    function moveInsurance(uint16 marketId, uint8 poolIndex, address to, uint amount) external override {
        delegateToImplementation(abi.encodeWithSignature("moveInsurance(uint16,uint8,address,uint256)", marketId, poolIndex, to, amount));
    }

    function setAllowedDepositTokens(address[] memory tokens, bool allowed) external override {
        delegateToImplementation(abi.encodeWithSignature("setAllowedDepositTokens(address[],bool)", tokens, allowed));
    }


}
