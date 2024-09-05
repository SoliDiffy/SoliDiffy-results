// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.8.3;

import {SafeERC20} from "../../libs/SafeERC20.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {
    AddressUpgradeable
} from "@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol";
import {MoneyMarket} from "../MoneyMarket.sol";
import {DecMath} from "../../libs/DecMath.sol";
import {HarvestVault} from "./imports/HarvestVault.sol";
import {HarvestStaking} from "./imports/HarvestStaking.sol";

contract HarvestMarket is MoneyMarket {
    using DecMath for uint256;
    using SafeERC20 for ERC20;
    using AddressUpgradeable for address;

    HarvestVault public vault;
    address public rewards;
    HarvestStaking public stakingPool;
    ERC20 public override stablecoin;

    function initialize(
        address _vault,
        address _rewards,
        address _stakingPool,
        address _rescuer,
        address _stablecoin
    ) external initializer {
        __MoneyMarket_init(_rescuer);

        // Verify input addresses
        require(
            _vault.isContract() &&
                _rewards != address(0) &&
                _stakingPool.isContract() &&
                _stablecoin.isContract(),
            "HarvestMarket: Invalid input address"
        );

        vault = HarvestVault(_vault);
        rewards = _rewards;
        stakingPool = HarvestStaking(_stakingPool);
        stablecoin = ERC20(_stablecoin);
    }

    

    

    

    

    

    

    /**
        Param setters
     */
    

    /**
        @dev See {Rescuable._authorizeRescue}
     */
    

    uint256[46] private __gap;
}
