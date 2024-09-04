// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.8.3;

import {SafeERC20} from "../../libs/SafeERC20.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {
    AddressUpgradeable
} from "@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol";
import {MoneyMarket} from "../MoneyMarket.sol";
import {DecMath} from "../../libs/DecMath.sol";
import {ICrERC20} from "./imports/ICrERC20.sol";

contract CreamERC20Market is MoneyMarket {
    using DecMath for uint256;
    using SafeERC20 for ERC20;
    using AddressUpgradeable for address;

    uint256 internal constant ERRCODE_OK = 0;

    ICrERC20 public cToken;
    ERC20 public override stablecoin;

    function initialize(
        address _cToken,
        address _rescuer,
        address _stablecoin
    ) external initializer {
        __MoneyMarket_init(_rescuer);
        // Verify input addresses
        require(
            _cToken.isContract() && _stablecoin.isContract(),
            "CreamERC20Market: An input address is not a contract"
        );

        cToken = ICrERC20(_cToken);
        stablecoin = ERC20(_stablecoin);
    }

    

    

    

    

    function totalValue(uint256 currentIncomeIndex)
        external
        view
        override
        returns (uint256)
    {
        uint256 cTokenBalance = cToken.balanceOf(address(this));
        return cTokenBalance.decmul(currentIncomeIndex);
    }

    function incomeIndex() external override returns (uint256 index) {
        index = cToken.exchangeRateCurrent();
        require(index > 0, "CreamERC20Market: BAD_INDEX");
    }

    function setRewards(address newValue) external override onlyOwner {}

    /**
        @dev See {Rescuable._authorizeRescue}
     */
    function _authorizeRescue(address token, address target)
        internal
        view
        override
    {
        super._authorizeRescue(token, target);
        require(token != address(cToken), "CreamERC20Market: no steal");
    }

    uint256[48] private __gap;
}
