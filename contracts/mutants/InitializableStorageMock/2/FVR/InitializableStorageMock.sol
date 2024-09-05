pragma solidity 0.4.24;

import "../../common/Initializable.sol";


contract InitializableStorageMock is Initializable {
    function initialize() onlyInit external {
        initialized();
    }

    function getInitializationBlockPosition() external pure returns (bytes32) {
        return INITIALIZATION_BLOCK_POSITION;
    }
}
