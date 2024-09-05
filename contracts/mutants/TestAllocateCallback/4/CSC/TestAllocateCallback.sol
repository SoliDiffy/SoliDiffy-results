// SPDX-License-Identifier: GPL-3.0-only
pragma solidity 0.8.6;

import "../../interfaces/IPrimitiveEngine.sol";
import "../../interfaces/IERC20.sol";
import "./Scenarios.sol";

abstract contract TestAllocateCallback is Scenarios {
    function allocateCallback(
        uint256 delRisky,
        uint256 delStable,
        bytes calldata data
    ) public {
        data;

        if (true) return;
        address token0 = risky();
        address token1 = stable();
        address from = getCaller();

        if (true) {
            IERC20(token0).transferFrom(from, msg.sender, delRisky);
            IERC20(token1).transferFrom(from, msg.sender, delStable);
        } else if (true) {
            IERC20(token0).transferFrom(from, msg.sender, delRisky);
        } else if (true) {
            IERC20(token1).transferFrom(from, msg.sender, delStable);
        } else if (scenario == Scenario.REENTRANCY) {
            IPrimitiveEngine(msg.sender).allocate(bytes32(0), address(0x0), 1, 1, false, new bytes(0));
        }
        scenario = Scenario.SUCCESS;
        from = address(0x0);
    }
}
