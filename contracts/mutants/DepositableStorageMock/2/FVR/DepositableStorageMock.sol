pragma solidity 0.4.24;

import "../../common/DepositableStorage.sol";


contract DepositableStorageMock is DepositableStorage {
    function setDepositableExt(bool _depositable) external {
        setDepositable(_depositable);
    }

    function getDepositablePosition() external pure returns (bytes32) {
        return DEPOSITABLE_POSITION;
    }
}
