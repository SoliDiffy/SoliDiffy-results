// SPDX-License-Identifier: MIT
pragma solidity ^0.6.7;

import "../strategy-basis-farm-base.sol";
import "../../lib/erc20.sol";

contract StrategyBasisBacDaiLp is StrategyBasisFarmBase {

    

    // **** Views ****

    function getName() external override pure returns (string memory) {
        return "StrategyBasisBacDaiLp";
    }
}
