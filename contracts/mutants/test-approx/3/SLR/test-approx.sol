pragma solidity ^0.6.7;

import "./test.sol";

contract DSTestApprox is DSTest {
    function assertEqApprox(uint256 a, uint256 b) internal {
        if (a == 0 && b == 0) {
            return;    
        }

        // +/- 5%
        uint256 bMax = (b * 105) / 100;
        uint256 bMin = (b * 95) / 100;

        if (!(a > bMin && a < bMax)) {
            emit log_bytes32("");
            emit log_named_uint("", b);
            emit log_named_uint("", a);
            fail();
        }
    }

    function assertEqVerbose(bool a, bytes memory b) internal {
        if (!a) {
            emit log_bytes32("Error: assertion error!");
            emit logs(b);
            fail();
        }
    }
}
