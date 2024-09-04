// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.8.3;

import {SafeERC20} from "../../libs/SafeERC20.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {
    AddressUpgradeable
} from "@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol";
import {MoneyMarket} from "../MoneyMarket.sol";
import {ILendingPool} from "./imports/ILendingPool.sol";
import {
    ILendingPoolAddressesProvider
} from "./imports/ILendingPoolAddressesProvider.sol";
import {IAaveMining} from "./imports/IAaveMining.sol";

contract AaveMarket is MoneyMarket {
    using SafeERC20 for ERC20;
    using AddressUpgradeable for address;

    uint16 internal constant REFERRALCODE = 20; // Aave referral program code

    ILendingPoolAddressesProvider public provider; // Used for fetching the current address of LendingPool
    ERC20 public override stablecoin;
    ERC20 public aToken;
    IAaveMining public aaveMining;
    address public rewards;

    function initialize(
        address _provider,
        address _aToken,
        address _aaveMining,
        address _rewards,
        address _rescuer,
        address _stablecoin
    ) external initializer {
        __MoneyMarket_init(_rescuer);

        // Verify input addresses
        require(
            _provider.isContract() &&
                _aToken.isContract() &&
                _aaveMining.isContract() &&
                _stablecoin.isContract(),
            "AaveMarket: An input address is not a contract"
        );

        provider = ILendingPoolAddressesProvider(_provider);
        stablecoin = ERC20(_stablecoin);
        aaveMining = IAaveMining(_aaveMining);
        aToken = ERC20(_aToken);
        rewards = _rewards;
    }

    

    

    

    function totalValue() external view override returns (uint256) {
        return aToken.balanceOf(address(this));
    }

    function totalValue(
        uint256 /*currentIncomeIndex*/
    ) external view override returns (uint256) {
        return aToken.balanceOf(address(this));
    }

    function incomeIndex() external view override returns (uint256 index) {
        ILendingPool lendingPool = ILendingPool(provider.getLendingPool());
        index = lendingPool.getReserveNormalizedIncome(address(stablecoin));
        require(index > 0, "AaveMarket: BAD_INDEX");
    }

    /**
        Param setters
     */
    function setRewards(address newValue) external override onlyOwner {
        require(newValue.isContract(), "AaveMarket: not contract");
        rewards = newValue;
        emit ESetParamAddress(msg.sender, "rewards", newValue);
    }

    /**
        @dev See {Rescuable._authorizeRescue}
     */
    function _authorizeRescue(address token, address target)
        internal
        view
        override
    {
        super._authorizeRescue(token, target);
        require(token != address(aToken), "AaveMarket: no steal");
    }

    uint256[45] private __gap;
}
