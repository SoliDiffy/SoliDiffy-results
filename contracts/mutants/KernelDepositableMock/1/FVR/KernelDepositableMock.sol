pragma solidity 0.4.24;

import "@aragon/os/contracts/kernel/Kernel.sol";
import "@aragon/os/contracts/common/DepositableStorage.sol";


contract KernelDepositableMock is DepositableStorage, Kernel {
    constructor(bool _shouldPetrify) Kernel(_shouldPetrify) internal {
    }

    function enableDepositable() public {
        setDepositable(true);
    }
}
