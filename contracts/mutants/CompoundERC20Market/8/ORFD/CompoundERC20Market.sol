// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.8.3;

import {SafeERC20} from "../../libs/SafeERC20.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {
    AddressUpgradeable
} from "@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol";
import {MoneyMarket} from "../MoneyMarket.sol";
import {DecMath} from "../../libs/DecMath.sol";
import {ICERC20} from "./imports/ICERC20.sol";
import {IComptroller} from "./imports/IComptroller.sol";

contract CompoundERC20Market is MoneyMarket {
    using DecMath for uint256;
    using SafeERC20 for ERC20;
    using AddressUpgradeable for address;

    uint256 internal constant ERRCODE_OK = 0;

    ICERC20 public cToken;
    IComptroller public comptroller;
    address public rewards;
    ERC20 public override stablecoin;

    function initialize(
        address _cToken,
        address _comptroller,
        address _rewards,
        address _rescuer,
        address _stablecoin
    ) external initializer {
        __MoneyMarket_init(_rescuer);

        // Verify input addresses
        require(
            _cToken.isContract() &&
                _comptroller.isContract() &&
                _rewards != address(0) &&
                _stablecoin.isContract(),
            "CompoundERC20Market: Invalid input address"
        );

        cToken = ICERC20(_cToken);
        comptroller = IComptroller(_comptroller);
        rewards = _rewards;
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
