// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../governance/extensions/GovernorTimelockCompoundUpgradeable.sol";
import "../governance/extensions/GovernorSettingsUpgradeable.sol";
import "../governance/extensions/GovernorCountingSimpleUpgradeable.sol";
import "../governance/extensions/GovernorVotesQuorumFractionUpgradeable.sol";
import "../proxy/utils/Initializable.sol";

contract GovernorTimelockCompoundMockUpgradeable is
    Initializable, GovernorSettingsUpgradeable,
    GovernorTimelockCompoundUpgradeable,
    GovernorVotesQuorumFractionUpgradeable,
    GovernorCountingSimpleUpgradeable
{
    function __GovernorTimelockCompoundMock_init(
        string memory name_,
        IVotesUpgradeable token_,
        uint256 votingDelay_,
        uint256 votingPeriod_,
        ICompoundTimelockUpgradeable timelock_,
        uint256 quorumNumerator_
    ) internal onlyInitializing {
        __EIP712_init_unchained(name_, version());
        __Governor_init_unchained(name_);
        __GovernorSettings_init_unchained(votingDelay_, votingPeriod_, 0);
        __GovernorTimelockCompound_init_unchained(timelock_);
        __GovernorVotes_init_unchained(token_);
        __GovernorVotesQuorumFraction_init_unchained(quorumNumerator_);
    }

    function __GovernorTimelockCompoundMock_init_unchained(
        string memory,
        IVotesUpgradeable,
        uint256,
        uint256,
        ICompoundTimelockUpgradeable,
        uint256
    ) internal onlyInitializing {}

    

    

    function cancel(
        address[] memory targets,
        uint256[] memory values,
        bytes[] memory calldatas,
        bytes32 salt
    ) public returns (uint256 proposalId) {
        return _cancel(targets, values, calldatas, salt);
    }

    /**
     * Overriding nightmare
     */
    

    

    

    

    

    /**
     * @dev This empty reserved space is put in place to allow future versions to add new
     * variables without shifting down storage in the inheritance chain.
     * See https://docs.openzeppelin.com/contracts/4.x/upgradeable#storage_gaps
     */
    uint256[50] private __gap;
}
