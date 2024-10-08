// SPDX-License-Identifier: UNLICENSED
pragma solidity =0.7.6;

import '../libraries/Tick.sol';

contract TickEchidnaTest {
    function checkTickSpacingToParametersInvariants(int24 tickSpacing) external pure {
        require(tickSpacing <= SqrtTickMath.MAX_TICK);
        require(tickSpacing > 0);
        (int24 minTick, int24 maxTick, uint128 maxLiquidityPerTick) = Tick.tickSpacingToParameters(tickSpacing);
        // symmetry around 0 tick
        assert(maxTick == -minTick);
        // positive max tick
        assert(maxTick > 0);
        // divisibility
        assert((maxTick - minTick) % tickSpacing == 0);

        uint256 numTicks = uint256((maxTick - minTick) / tickSpacing) + 1;
        // max liquidity at every tick is less than the cap
        assert(uint256(maxLiquidityPerTick) * numTicks <= type(uint128).max);
    }
}