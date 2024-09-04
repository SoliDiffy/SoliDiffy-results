// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.8.3;

import {SafeERC20} from "../../libs/SafeERC20.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {
    AddressUpgradeable
} from "@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol";
import {MoneyMarket} from "../MoneyMarket.sol";
import {DecMath} from "../../libs/DecMath.sol";
import {IBToken} from "./imports/IBToken.sol";
import {IBComptroller} from "./imports/IBComptroller.sol";

contract BProtocolMarket is MoneyMarket {
    using DecMath for uint256;
    using SafeERC20 for ERC20;
    using AddressUpgradeable for address;

    uint256 internal constant ERRCODE_OK = 0;

    IBToken public bToken;
    IBComptroller public bComptroller;
    address public rewards;
    ERC20 public override stablecoin;

    function initialize(
        address _bToken,
        address _bComptroller,
        address _rewards,
        address _rescuer,
        address _stablecoin
    ) external initializer {
        __MoneyMarket_init(_rescuer);

        // Verify input addresses
        require(
            _bToken.isContract() &&
                _bComptroller.isContract() &&
                _rewards != address(0) &&
                _stablecoin.isContract(),
            "BProtocolMarket: Invalid input address"
        );

        bToken = IBToken(_bToken);
        bComptroller = IBComptroller(_bComptroller);
        rewards = _rewards;
        stablecoin = ERC20(_stablecoin);
    }

    

    

    

    

    

    function incomeIndex() external override returns (uint256 index) {
        index = bToken.exchangeRateCurrent();
        require(index > 0, "BProtocolMarket: BAD_INDEX");
    }

    /**
        Param setters
     */
    function setRewards(address newValue) external override onlyOwner {
        require(newValue.isContract(), "BProtocolMarket: not contract");
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
        require(token != address(bToken), "BProtocolMarket: no steal");
    }

    uint256[46] private __gap;
}
