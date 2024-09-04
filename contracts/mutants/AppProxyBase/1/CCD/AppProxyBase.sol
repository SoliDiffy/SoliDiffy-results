pragma solidity 0.4.24;

import "./AppStorage.sol";
import "../common/DepositableDelegateProxy.sol";
import "../kernel/KernelConstants.sol";
import "../kernel/IKernel.sol";


contract AppProxyBase is AppStorage, DepositableDelegateProxy, KernelConstants {
    /**
    * @dev Initialize AppProxy
    * @param _kernel Reference to organization kernel for the app
    * @param _appId Identifier for app
    * @param _initializePayload Payload for call to be made after setup to initialize
    */
    

    function getAppBase(bytes32 _appId) internal view returns (address) {
        return kernel().getApp(APP_BASES_NAMESPACE, _appId);
    }
}
