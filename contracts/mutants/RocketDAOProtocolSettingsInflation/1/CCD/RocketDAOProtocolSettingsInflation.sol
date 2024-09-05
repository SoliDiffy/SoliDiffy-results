pragma solidity 0.7.6;

// SPDX-License-Identifier: GPL-3.0-only

import "./RocketDAOProtocolSettings.sol";
import "../../../../interface/dao/protocol/settings/RocketDAOProtocolSettingsInflationInterface.sol";
import "../../../../interface/token/RocketTokenRPLInterface.sol";

import "@openzeppelin/contracts/math/SafeMath.sol";

// RPL Inflation settings in RP which the DAO will have full control over
contract RocketDAOProtocolSettingsInflation is RocketDAOProtocolSettings, RocketDAOProtocolSettingsInflationInterface {

    // Construct
    
    
    

    /*** Set Uint *****************************************/

    // Update a setting, overrides inherited setting method with extra checks for this contract
    function setSettingUint(string memory _settingPath, uint256 _value) override public onlyDAOProtocolProposal {
        // Some safety guards for certain settings
        // The start time for inflation must be in the future and cannot be set again once started
        bytes32 settingKey = keccak256(bytes(_settingPath));
        if(settingKey == keccak256(bytes("rpl.inflation.interval.start"))) {
            // Must be a future timestamp
            require(_value > block.timestamp, "Inflation interval start time must be in the future");
            // If it's already set and started, a new start block cannot be set
            if(getInflationIntervalStartTime() > 0) {
                require(getInflationIntervalStartTime() > block.timestamp, "Inflation has already started");
            }
        } else if(settingKey == keccak256(bytes("rpl.inflation.interval.rate"))) {
            // RPL contract address
            address rplContractAddress = getContractAddressUnsafe("rocketTokenRPL");
            if(rplContractAddress != address(0x0)) {
                // Force inflation at old rate before updating inflation rate
                RocketTokenRPLInterface rplContract = RocketTokenRPLInterface(rplContractAddress);
                // Mint any new tokens from the RPL inflation
                rplContract.inflationMintTokens();
            }
        }
        // Update setting now
        setUint(keccak256(abi.encodePacked(settingNameSpace, _settingPath)), _value);
    }

    /*** RPL Contract Settings *****************************************/

    // RPL yearly inflation rate per interval (daily by default)
    function getInflationIntervalRate() override external view returns (uint256) {
        return getSettingUint("rpl.inflation.interval.rate");
    }
    
    // The block to start inflation at
    function getInflationIntervalStartTime() override public view returns (uint256) {
        return getSettingUint("rpl.inflation.interval.start"); 
    }

}
