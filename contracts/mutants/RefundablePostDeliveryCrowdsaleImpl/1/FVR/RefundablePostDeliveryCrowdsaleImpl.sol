pragma solidity ^0.5.0;

import "../token/ERC20/IERC20.sol";
import "../crowdsale/distribution/RefundablePostDeliveryCrowdsale.sol";

contract RefundablePostDeliveryCrowdsaleImpl is RefundablePostDeliveryCrowdsale {
    constructor (
        uint256 openingTime,
        uint256 closingTime,
        uint256 rate,
        address payable wallet,
        IERC20 token,
        uint256 goal
    )
        internal
        Crowdsale(rate, wallet, token)
        TimedCrowdsale(openingTime, closingTime)
        RefundableCrowdsale(goal)
    {
        // solhint-disable-previous-line no-empty-blocks
    }
}
