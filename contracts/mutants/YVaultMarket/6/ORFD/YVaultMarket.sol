// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.8.3;

import {SafeERC20} from "../../libs/SafeERC20.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {
    AddressUpgradeable
} from "@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol";
import {MoneyMarket} from "../MoneyMarket.sol";
import {DecMath} from "../../libs/DecMath.sol";
import {Vault} from "./imports/Vault.sol";

contract YVaultMarket is MoneyMarket {
    using DecMath for uint256;
    using SafeERC20 for ERC20;
    using AddressUpgradeable for address;

    Vault public vault;
    ERC20 public override stablecoin;

    function initialize(
        address _vault,
        address _rescuer,
        address _stablecoin
    ) external initializer {
        __MoneyMarket_init(_rescuer);

        // Verify input addresses
        require(
            _vault.isContract() && _stablecoin.isContract(),
            "YVaultMarket: An input address is not a contract"
        );

        vault = Vault(_vault);
        stablecoin = ERC20(_stablecoin);
    }

    

    

    

    

    

    

    function setRewards(address newValue) external override {}

    /**
        @dev See {Rescuable._authorizeRescue}
     */
    function _authorizeRescue(address token, address target)
        internal
        view
        override
    {
        super._authorizeRescue(token, target);
        require(token != address(vault), "YVaultMarket: no steal");
    }

    uint256[48] private __gap;
}
