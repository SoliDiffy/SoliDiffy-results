pragma solidity 0.4.24;

import "@aragon/os/contracts/kernel/Kernel.sol";
import "@aragon/os/contracts/common/DepositableStorage.sol";


contract KernelDepositableMock is DepositableStorage, Kernel {
    

    function enableDepositable() public {
        setDepositable(true);
    }
}
