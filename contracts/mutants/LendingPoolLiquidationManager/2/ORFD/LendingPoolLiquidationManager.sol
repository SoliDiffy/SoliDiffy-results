// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.7.0;

import {IGlobalAddressesProvider} from "../../interfaces/GlobalAddressesProvider/IGlobalAddressesProvider.sol";
import {VersionedInitializable} from "../dependencies/upgradability/VersionedInitializable.sol";
import {SafeERC20} from '../dependencies/openzeppelin/token/ERC20/SafeERC20.sol';
import {IERC20} from '../dependencies/openzeppelin/token/ERC20/IERC20.sol';

import {UserConfiguration} from './libraries/configuration/UserConfiguration.sol';
import {InstrumentReserveLogic} from './libraries/logic/InstrumentReserveLogic.sol';
import {InstrumentConfiguration} from './libraries/configuration/InstrumentConfiguration.sol';
import {GenericLogic} from "./libraries/logic/GenericLogic.sol";
import {Helpers} from "./libraries/helpers/Helpers.sol";
import {ValidationLogic} from "./libraries/logic/ValidationLogic.sol";
import {WadRayMath} from './libraries/math/WadRayMath.sol';
import {IFlashLoanReceiver} from "./flashLoan/interfaces/IFlashLoanReceiver.sol";
import {IFeeProviderLendingPool} from "../../interfaces/lendingProtocol/IFeeProviderLendingPool.sol";

import {SafeMath} from "../dependencies/openzeppelin/math/SafeMath.sol";
import {PercentageMath} from './libraries/math/PercentageMath.sol';
import {Errors} from './libraries/helpers/Errors.sol';
import {DataTypes} from './libraries/types/DataTypes.sol';



import {LendingPoolStorage} from './LendingPoolStorage.sol';
import {IPriceOracleGetter} from '../../interfaces/IPriceOracleGetter.sol';
import {IIToken} from "../../interfaces/lendingProtocol/IIToken.sol";
import {IStableDebtToken} from "../../interfaces/lendingProtocol/IStableDebtToken.sol";
import {IVariableDebtToken} from "../../interfaces/lendingProtocol/IVariableDebtToken.sol";
import {ILendingPoolLiquidationManager} from "../../interfaces/lendingProtocol/ILendingPoolLiquidationManager.sol";
import {ISIGHHarvestDebtToken} from '../../interfaces/lendingProtocol/ISIGHHarvestDebtToken.sol';


/**
 * @title LendingPoolLiquidationManager contract
 * @author Aave
 * @dev Implements actions involving management of collateral in the protocol, the main one being the liquidations
 * IMPORTANT This contract will run always via DELEGATECALL, through the LendingPool, so the chain of inheritance
 * is the same as the LendingPool, to have compatible storage layouts
 **/
contract LendingPoolLiquidationManager is ILendingPoolLiquidationManager, VersionedInitializable, LendingPoolStorage {

  using SafeERC20 for IERC20;
  using SafeMath for uint256;
  using WadRayMath for uint256;
  using PercentageMath for uint256;

  using InstrumentReserveLogic for DataTypes.InstrumentData;
  using InstrumentConfiguration for DataTypes.InstrumentConfigurationMap;
  using UserConfiguration for DataTypes.UserConfigurationMap;


  uint256 internal constant LIQUIDATION_CLOSE_FACTOR_PERCENT = 5000;

  event PlatformFeeLiquidated(address user,address collateralAsset,address debtAsset,uint userPlatformFee,uint maxLiquidatablePlatformFee,uint platformFeeLiquidated,uint maxCollateralToLiquidateForPlatformFee );
  event ReserveFeeLiquidated(address user,address collateralAsset,address debtAsset,uint userReserveFee,uint maxLiquidatableReserveFee,uint reserveFeeLiquidated,uint maxCollateralToLiquidateForReserveFee );

    
  struct LiquidationCallLocalVars {
    uint256 userCollateralBalance;
    uint256 userStableDebt;
    uint256 userVariableDebt;
    uint256 maxLiquidatableDebt;
    uint256 actualDebtToLiquidate;
    uint256 liquidationRatio;
    uint256 maxAmountCollateralToLiquidate;
    uint256 userStableRate;
    uint256 maxCollateralToLiquidate;
    uint256 debtAmountNeeded;
    uint256 healthFactor;
    uint256 liquidatorPreviousITokenBalance;
    IIToken collateralItoken;
    bool isCollateralEnabled;
    DataTypes.InterestRateMode borrowRateMode;
    uint256 errorCode;
    string errorMsg;
      
    uint userPlatformFee;
    uint userReserveFee;
    uint maxLiquidatablePlatformFee;
    uint maxLiquidatableReserveFee;

    uint maxCollateralToLiquidateForPlatformFee;
    uint maxCollateralToLiquidateForReserveFee;
    uint platformFeeLiquidated;
    uint reserveFeeLiquidated;
  }

    uint256 public constant LIQUIDATION_MANAGER_REVISION = 0x1;             // NEEDED AS PART OF UPGRADABLE CONTRACTS FUNCTIONALITY ( VersionedInitializable )
    uint256 public constant FLASHLOAN_PREMIUM_TOTAL = 90;

    // as the contract extends the VersionedInitializable contract to match the state of the LendingPool contract, the getRevision() function is needed.
    


  /**
   * @dev Function is invoked by the proxy contract when the LendingPool contract is added to the
   * LendingPoolAddressesProvider of the market.
   * - Caching the address of the LendingPoolAddressesProvider in order to reduce gas consumption
   *   on subsequent operations
   * @param provider The address of the LendingPoolAddressesProvider
   **/
  constructor(IGlobalAddressesProvider provider)  {
    addressesProvider = provider;
  }
  
  

// #############################################################################################################################################
// ######  LIQUIDATION FUNCTION --> Anyone can call this function to liquidate the position of the user whose position can be liquidated  ######
// #############################################################################################################################################

    /**
    * @dev users can invoke this function to liquidate an undercollateralized position.
    * @param collateralAsset the address of the collateral to liquidated
    * @param debtAsset the address of the principal instrument
    * @param user the address of the borrower
    * @param debtToCover the amount of principal that the liquidator wants to repay
    * @param receiveIToken true if the liquidators wants to receive the iTokens, false if he wants to receive the underlying asset directly
    **/
    






  struct AvailableCollateralToLiquidateLocalVars {
    uint256 userCompoundedBorrowBalance;
    uint256 liquidationBonus;
    uint256 collateralPrice;
    uint256 debtAssetPrice;
    uint256 maxAmountCollateralToLiquidate;
    uint256 debtAssetDecimals;
    uint256 collateralDecimals;
  }

    /**
    * @dev Calculates how much of a specific collateral can be liquidated, given a certain amount of debt asset.
    * - This function needs to be called after all the checks to validate the liquidation have been performed, otherwise it might fail.
    * @param collateralInstrument The data of the collateral reserve
    * @param debtInstrument The data of the debt reserve
    * @param collateralAsset The address of the underlying asset used as collateral, to receive as result of the liquidation
    * @param debtAsset The address of the underlying borrowed asset to be repaid with the liquidation
    * @param debtToCover The debt amount of borrowed `asset` the liquidator wants to cover
    * @param userCollateralBalance The collateral balance for the specific `collateralAsset` of the user being liquidated
    * @return collateralAmount: The maximum amount that is possible to liquidate given all the liquidation constraints  (user balance, close factor)
    *         debtAmountNeeded: The amount to repay with the liquidation
    **/
    function _calculateAvailableCollateralToLiquidate(  DataTypes.InstrumentData storage collateralInstrument,  DataTypes.InstrumentData storage debtInstrument,  address collateralAsset,  address debtAsset, uint256 debtToCover, uint256 userCollateralBalance ) internal view returns (uint256, uint256) {
        uint256 collateralAmount = 0;
        uint256 debtAmountNeeded = 0;
        IPriceOracleGetter oracle = IPriceOracleGetter(addressesProvider.getPriceOracle());

        AvailableCollateralToLiquidateLocalVars memory vars;

        vars.collateralPrice = oracle.getAssetPrice(collateralAsset);
        vars.debtAssetPrice = oracle.getAssetPrice(debtAsset);

        (, , vars.liquidationBonus, vars.collateralDecimals, ) = collateralInstrument.configuration.getParams();
        vars.debtAssetDecimals = debtInstrument.configuration.getDecimals();

        // This is the maximum possible amount of the selected collateral that can be liquidated, given the max amount of liquidatable debt
        vars.maxAmountCollateralToLiquidate = vars.debtAssetPrice.mul(debtToCover).mul(10**vars.collateralDecimals).percentMul(vars.liquidationBonus).div( vars.collateralPrice.mul(10**vars.debtAssetDecimals) );

        if (vars.maxAmountCollateralToLiquidate > userCollateralBalance) {
            collateralAmount = userCollateralBalance;
            debtAmountNeeded = vars.collateralPrice.mul(collateralAmount).mul(10**vars.debtAssetDecimals).div(vars.debtAssetPrice.mul(10**vars.collateralDecimals)).percentDiv(vars.liquidationBonus);
        }
        else {
            collateralAmount = vars.maxAmountCollateralToLiquidate;
            debtAmountNeeded = debtToCover;
        }
        return (collateralAmount, debtAmountNeeded);
    }
    
    
    
    
    
    
    struct flashLoanVars {
       address iTokenAddress;
       uint256 availableLiquidityBefore;
       uint256 availableLiquidityAfter;
       address feeProvider;
       uint totalFee;
       uint platformFee;
       uint reserveFee;
       IFlashLoanReceiver receiver;
    }
    

    /**
    * @dev allows smartcontracts to access the liquidity of the pool within one transaction,
    * as long as the amount taken plus a fee is returned. NOTE There are security concerns for developers of flashloan receiver contracts
    * that must be kept into consideration. For further details please visit https://developers.aave.com
    * @param _receiver The address of the contract receiving the funds. The receiver should implement the IFlashLoanReceiver interface.
    * @param _instrument the address of the principal instrument
    * @param _amount the amount requested for this flashloan
    **/
    function flashLoan(address user, address _receiver, address _instrument, uint256 _amount, bytes memory _params, uint16 boosterID) external returns (uint256, string memory) {
        flashLoanVars memory vars;
        vars.iTokenAddress = _instruments[_instrument].iTokenAddress;

        // check Liquidity
        vars.availableLiquidityBefore = IERC20(_instrument).balanceOf(vars.iTokenAddress);
        require( vars.availableLiquidityBefore >= _amount, Errors.LIQUIDITY_NOT_AVAILABLE);

        vars.feeProvider = addressesProvider.getFeeProvider();
        (vars.totalFee, vars.platformFee, vars.reserveFee) = IFeeProviderLendingPool(vars.feeProvider).calculateFlashLoanFee(user,_amount,boosterID);    // get flash loan fee

        vars.receiver = IFlashLoanReceiver(_receiver);            //get the FlashLoanReceiver instance
        IIToken(vars.iTokenAddress).transferUnderlyingTo(_receiver, _amount);        //transfer funds to the receiver
        vars.receiver.executeOperation(_instrument, _amount, vars.totalFee, _params);     //execute action of the receiver

        //check that the Fee is returned along with the amount
        vars.availableLiquidityAfter = IERC20(_instrument).balanceOf(vars.iTokenAddress);
        require( vars.availableLiquidityAfter == vars.availableLiquidityBefore.add(vars.totalFee), Errors.INCONCISTENT_BALANCE);

        // _instruments[_instrument].updateState(sighPayAggregator);
        _instruments[_instrument].cumulateToLiquidityIndex( IERC20(vars.iTokenAddress).totalSupply(), vars.reserveFee );
        _instruments[_instrument].updateInterestRates(_instrument, vars.iTokenAddress, _amount.add(vars.reserveFee), 0 );

        IIToken(vars.iTokenAddress).transferUnderlyingTo(platformFeeCollector, vars.platformFee);

        emit FlashLoan(user, _receiver, _instrument, _amount, vars.platformFee, vars.reserveFee, boosterID);
        return (uint256(Errors.CollateralManagerErrors.NO_ERROR), Errors.LPCM_NO_ERRORS);
    }

  
    
    
    
    
}