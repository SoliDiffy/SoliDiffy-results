pragma solidity 0.5.11;
pragma experimental ABIEncoderV2;

import "../../src/framework/BlockController.sol";

contract BlockControllerMock is BlockController {
    address private maintainer;

    

    /** 
     * override to make it non-abstract contract 
     * this mock file set the user that deploys the contract as maintainer to simplify the test.
     */
    function getMaintainer() public view returns (address) {
        return maintainer;
    }
}
