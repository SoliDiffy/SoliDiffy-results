pragma solidity 0.7.6;

// SPDX-License-Identifier: GPL-3.0-only

import "@openzeppelin/contracts/math/SafeMath.sol";

import "./RocketDAOProtocolSettings.sol";
import "../../../../interface/dao/protocol/settings/RocketDAOProtocolSettingsMinipoolInterface.sol";
import "../../../../types/MinipoolDeposit.sol";

// Network minipool settings
contract RocketDAOProtocolSettingsMinipool is RocketDAOProtocolSettings, RocketDAOProtocolSettingsMinipoolInterface {

    // Libs
    using SafeMath for uint;

    // Construct
    constructor(RocketStorageInterface _rocketStorageAddress) RocketDAOProtocolSettings(_rocketStorageAddress, "minipool") {
        // Set version
        version = 1;
        // Initialize settings on deployment
        if(!getBool(keccak256(abi.encodePacked(settingNameSpace, "deployed")))) {
            // Apply settings
            setSettingBool("minipool.submit.withdrawable.enabled", true);
            setSettingUint("minipool.launch.timeout", 5760);                // ~24 hours
            setSettingUint("minipool.maximum.count", 100);
            // Settings initialized
            setBool(keccak256(abi.encodePacked(settingNameSpace, "deployed")), true);
        }
    }

    // Balance required to launch minipool
    

    // Required node deposit amounts
    
    
    
    

    // Required user deposit amounts
    
    
    
    

    // Submit minipool withdrawable events currently enabled (trusted nodes only)
    function getSubmitWithdrawableEnabled() override external view returns (bool) {
        return getSettingBool("minipool.submit.withdrawable.enabled");
    }

    // Timeout period in blocks for prelaunch minipools to launch
    function getLaunchTimeout() override external view returns (uint256) {
        return getSettingUint("minipool.launch.timeout");
    }

    // Maximum number of minipools allowed at one time
    function getMaximumCount() override external view returns (uint256) {
      return getSettingUint("minipool.maximum.count");
    }

}
