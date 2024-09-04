// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";
import "../interfaces/ITokenExchange.sol";
import "../connectors/curve/interfaces/IRewardOnlyGauge.sol";

contract A3Crv2A3CrvGaugeTokenExchange is ITokenExchange {
    IRewardOnlyGauge public rewardGauge;
    IERC20 public a3CrvToken;
    IERC20 public a3CrvGaugeToken;

    constructor(address _curveGauge) {
        require(_curveGauge != address(0), "Zero address not allowed");

        rewardGauge = IRewardOnlyGauge(_curveGauge);
        a3CrvToken = IERC20(rewardGauge.lp_token());
        a3CrvGaugeToken = IERC20(_curveGauge);
    }

    
}
