// SPDX-License-Identifier: GPL-2.0-only
// Copyright 2020 Spilsbury Holdings Ltd
pragma solidity >=0.6.10 <=0.8.10;
pragma experimental ABIEncoderV2;

import { SafeMath } from "@openzeppelin/contracts/utils/math/SafeMath.sol";
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import { AztecTypes } from "../../aztec/AztecTypes.sol";

import { IDefiBridge } from "../../interfaces/IDefiBridge.sol";
import { ISetToken } from "./interfaces/ISetToken.sol";
import { IController } from "./interfaces/IController.sol";
import { IExchangeIssuance } from "./interfaces/IExchangeIssuance.sol";
import { IRollupProcessor } from "../../interfaces/IRollupProcessor.sol";

contract IssuanceBridge is IDefiBridge {
    using SafeMath for uint256;

    address public immutable rollupProcessor;

    IExchangeIssuance exchangeIssuance;
    IController setController; // used to check if address is SetToken

    constructor(
        address _rollupProcessor,
        address _exchangeIssuance,
        address _setController
    ) public {
        rollupProcessor = _rollupProcessor;
        exchangeIssuance = IExchangeIssuance(_exchangeIssuance);
        setController = IController(_setController);
    }

    /**
     * @notice Function that allows to ISSUE or REDEEM SetToken in exchange for ETH or ERC20
     * @param inputAssetA    - If ISSUE SET: ETH or ERC20        | If REDEEM SET: SetToken
     * @param outputAssetA   - If ISSUE SET: setToken            | If REDEEM SET: ETH or ERC20
     * @param inputValue     - If ISSUE SET: ETH or ERC20 amount | If REDEEM SET: SetToken amount
     * @return outputValueA  - If ISSUE SET: SetToken amount     | If REDEEM SET: ETH or ERC20 amount
     * @return isAsync a flag to toggle if this bridge interaction will return assets at a later
            date after some third party contract has interacted with it via finalise()
     */

    

    // Empty fallback function in order to receive ETH 
    receive() external payable {}
    
    function finalise(
        AztecTypes.AztecAsset calldata inputAssetA,
        AztecTypes.AztecAsset calldata inputAssetB,
        AztecTypes.AztecAsset calldata outputAssetA,
        AztecTypes.AztecAsset calldata outputAssetB,
        uint256 interactionNonce,
        uint64 auxData
    ) external payable override returns (uint256, uint256, bool) {
        require(false, "IssuanceBridge: ASYNC_MODE_DISABLED");
    }
}
