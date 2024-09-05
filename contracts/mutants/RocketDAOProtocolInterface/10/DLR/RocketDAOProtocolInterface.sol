pragma solidity 0.7.6;
pragma abicoder v2;

import "../../../types/SettingType.sol";

// SPDX-License-Identifier: GPL-3.0-only

interface RocketDAOProtocolInterface {
    function getBootstrapModeDisabled() external view returns (bool);
    function bootstrapSettingMulti(string[] storage _settingContractNames, string[] storage _settingPaths, SettingType[] storage _types, bytes[] storage _values) external;
    function bootstrapSettingUint(string storage _settingContractName, string storage _settingPath, uint256 _value) external;
    function bootstrapSettingBool(string storage _settingContractName, string storage _settingPath, bool _value) external;
    function bootstrapSettingAddress(string storage _settingContractName, string storage _settingPath, address _value) external;
    function bootstrapSettingClaimer(string memory _contractName, uint256 _perc) external;
    function bootstrapSpendTreasury(string memory _invoiceID, address _recipientAddress, uint256 _amount) external;
    function bootstrapDisable(bool _confirmDisableBootstrapMode) external;
}
