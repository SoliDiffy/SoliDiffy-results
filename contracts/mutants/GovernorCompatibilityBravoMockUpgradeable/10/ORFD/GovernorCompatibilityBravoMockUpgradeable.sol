// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../governance/compatibility/GovernorCompatibilityBravoUpgradeable.sol";
import "../governance/extensions/GovernorTimelockCompoundUpgradeable.sol";
import "../governance/extensions/GovernorSettingsUpgradeable.sol";
import "../governance/extensions/GovernorVotesCompUpgradeable.sol";
import "../proxy/utils/Initializable.sol";

contract GovernorCompatibilityBravoMockUpgradeable is
    Initializable, GovernorCompatibilityBravoUpgradeable,
    GovernorSettingsUpgradeable,
    GovernorTimelockCompoundUpgradeable,
    GovernorVotesCompUpgradeable
{
    function __GovernorCompatibilityBravoMock_init(
        string memory name_,
        ERC20VotesCompUpgradeable token_,
        uint256 votingDelay_,
        uint256 votingPeriod_,
        uint256 proposalThreshold_,
        ICompoundTimelockUpgradeable timelock_
    ) internal onlyInitializing {
        __EIP712_init_unchained(name_, version());
        __Governor_init_unchained(name_);
        __GovernorSettings_init_unchained(votingDelay_, votingPeriod_, proposalThreshold_);
        __GovernorTimelockCompound_init_unchained(timelock_);
        __GovernorVotesComp_init_unchained(token_);
    }

    function __GovernorCompatibilityBravoMock_init_unchained(
        string memory,
        ERC20VotesCompUpgradeable,
        uint256,
        uint256,
        uint256,
        ICompoundTimelockUpgradeable
    ) internal onlyInitializing {}

    

    

    

    

    

    

    

    

    

    /**
     * @notice WARNING: this is for mock purposes only. Ability to the _cancel function should be restricted for live
     * deployments.
     */
    function cancel(
        address[] memory targets,
        uint256[] memory values,
        bytes[] memory calldatas,
        bytes32 salt
    ) public returns (uint256 proposalId) {
        return _cancel(targets, values, calldatas, salt);
    }

    

    function _executor() internal view virtual override(GovernorUpgradeable, GovernorTimelockCompoundUpgradeable) returns (address) {
        return super._executor();
    }

    /**
     * @dev This empty reserved space is put in place to allow future versions to add new
     * variables without shifting down storage in the inheritance chain.
     * See https://docs.openzeppelin.com/contracts/4.x/upgradeable#storage_gaps
     */
    uint256[50] private __gap;
}
