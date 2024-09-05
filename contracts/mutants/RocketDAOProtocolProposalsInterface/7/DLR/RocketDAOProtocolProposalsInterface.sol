pragma solidity 0.7.6;
pragma abicoder v2;

import "../../../types/SettingType.sol";

// SPDX-License-Identifier: GPL-3.0-only

interface RocketDAOProtocolProposalsInterface {
    function proposalSettingMulti(string[] storage _settingContractNames, string[] storage _settingPaths, SettingType[] storage _types, bytes[] storage _data) external;
    function proposalSettingUint(string storage _settingContractName, string storage _settingPath, uint256 _value) external;
    function proposalSettingBool(string storage _settingContractName, string memory _settingPath, bool _value) external;
    function proposalSettingAddress(string memory _settingContractName, string memory _settingPath, address _value) external;
    function proposalSettingRewardsClaimer(string memory _contractName, uint256 _perc) external;
    function proposalSpendTreasury(string memory _invoiceID, address _recipientAddress, uint256 _amount) external;
}
