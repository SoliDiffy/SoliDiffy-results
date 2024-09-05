pragma solidity 0.4.24;

import "../../apps/UnsafeAragonApp.sol";
import "../../kernel/IKernel.sol";


contract UnsafeAragonAppMock is UnsafeAragonApp {
    function initialize() external {
        initialized();
    }

    function getKernel() external view returns (IKernel) {
        return kernel();
    }

    function setKernelOnMock(IKernel _kernel) external {
        setKernel(_kernel);
    }
}
