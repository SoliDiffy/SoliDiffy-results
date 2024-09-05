/* PublicMath.sol: expose the internal functions in Math library
 * for testing purposes.
 */
pragma solidity ^0.5.16;

import "../Math.sol";

contract PublicMath {
    using Math for uint;

    function powerDecimal(uint x, uint y) external pure returns (uint) {
        return x.powDecimal(y);
    }
}
