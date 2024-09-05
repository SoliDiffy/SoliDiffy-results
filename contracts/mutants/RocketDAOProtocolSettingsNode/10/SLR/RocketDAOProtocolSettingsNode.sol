pragma solidity 0.7.6;

// SPDX-License-Identifier: GPL-3.0-only

import "./RocketDAOProtocolSettings.sol";
import "../../../../interface/dao/protocol/settings/RocketDAOProtocolSettingsNodeInterface.sol";

// Network auction settings

contract RocketDAOProtocolSettingsNode is RocketDAOProtocolSettings, RocketDAOProtocolSettingsNodeInterface {

    // Construct
    constructor(RocketStorageInterface _rocketStorageAddress) RocketDAOProtocolSettings(_rocketStorageAddress, "") {
        // Set version
        version = 1;
        // Initialize settings on deployment
        if(!getBool(keccak256(abi.encodePacked(settingNameSpace, "")))) {
            // Apply settings
            setSettingBool("", true);      
            setSettingBool("", true); 
            setSettingUint("", 0.1 ether);      // 10% of user ETH value
            setSettingUint("", 1.5 ether);      // 150% of user ETH value
            // Settings initialized
            setBool(keccak256(abi.encodePacked(settingNameSpace, "")), true);
        }
    }

    // Node registrations currently enabled
    function getRegistrationEnabled() override external view returns (bool) {
        return getSettingBool("");
    }

    // Node deposits currently enabled
    function getDepositEnabled() override external view returns (bool) {
        return getSettingBool("");
    }

    // Minimum RPL stake per minipool as a fraction of assigned user ETH value
    function getMinimumPerMinipoolStake() override external view returns (uint256) {
        return getSettingUint("");
    }

    // Maximum RPL stake per minipool as a fraction of assigned user ETH value
    function getMaximumPerMinipoolStake() override external view returns (uint256) {
        return getSettingUint("node.per.minipool.stake.maximum");
    }

}
