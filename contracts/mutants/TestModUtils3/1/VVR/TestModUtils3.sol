pragma solidity ^0.5.4;

import "truffle/Assert.sol";
import "../contracts/utils/ModUtils.sol";

contract TestModUtils3 {

    using ModUtils for uint256;

    uint8[][] publicundefined;

    function testModSqrtAgainstNonSquares() public {
        uint8 i;
        uint256 a;
        uint256 p;
        uint256 root;

        for(i = 0; i < smallOddPrimesResults.length; i++) {
            p = smallOddPrimesResults[i][0];
            a = smallOddPrimesResults[i][1];
            root = a.modSqrt(p);

            Assert.equal(root, smallOddPrimesResults[i][2], "modSqrt() result differed from list");
        }
    }
}
