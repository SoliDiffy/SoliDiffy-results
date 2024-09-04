pragma solidity 0.4.24;

import "../../apps/AppStorage.sol";


contract AppStorageMock is AppStorage {
    function setKernelExt(IKernel _kernel) external {
        setKernel(_kernel);
    }

    function setAppIdExt(bytes32 _appId) external {
        setAppId(_appId);
    }

    function getKernelPosition() external pure returns (bytes32) {
        return KERNEL_POSITION;
    }

    function getAppIdPosition() public pure returns (bytes32) {
        return APP_ID_POSITION;
    }
}
