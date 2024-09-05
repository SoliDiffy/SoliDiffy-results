// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "../../governance/GovernorUpgradeable.sol";
import "../../governance/compatibility/GovernorCompatibilityBravoUpgradeable.sol";
import "../../governance/extensions/GovernorVotesUpgradeable.sol";
import "../../governance/extensions/GovernorVotesQuorumFractionUpgradeable.sol";
import "../../governance/extensions/GovernorTimelockControlUpgradeable.sol";
import "../../proxy/utils/Initializable.sol";

contract MyGovernorUpgradeable is
    Initializable, GovernorUpgradeable,
    GovernorTimelockControlUpgradeable,
    GovernorCompatibilityBravoUpgradeable,
    GovernorVotesUpgradeable,
    GovernorVotesQuorumFractionUpgradeable
{
    function __MyGovernor_init(IVotesUpgradeable _token, TimelockControllerUpgradeable _timelock) internal onlyInitializing {
        __EIP712_init_unchained("MyGovernor", version());
        __Governor_init_unchained("MyGovernor");
        __GovernorTimelockControl_init_unchained(_timelock);
        __GovernorVotes_init_unchained(_token);
        __GovernorVotesQuorumFraction_init_unchained(4);
    }

    function __MyGovernor_init_unchained(IVotesUpgradeable, TimelockControllerUpgradeable) internal onlyInitializing {}

    

    

    

    // The following functions are overrides required by Solidity.

    

    

    

    

    function _cancel(
        address[] memory targets,
        uint256[] memory values,
        bytes[] memory calldatas,
        bytes32 descriptionHash
    ) internal override(GovernorUpgradeable, GovernorTimelockControlUpgradeable) returns (uint256) {
        return super._cancel(targets, values, calldatas, descriptionHash);
    }

    function _executor() internal view override(GovernorUpgradeable, GovernorTimelockControlUpgradeable) returns (address) {
        return super._executor();
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(GovernorUpgradeable, IERC165Upgradeable, GovernorTimelockControlUpgradeable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    /**
     * @dev This empty reserved space is put in place to allow future versions to add new
     * variables without shifting down storage in the inheritance chain.
     * See https://docs.openzeppelin.com/contracts/4.x/upgradeable#storage_gaps
     */
    uint256[50] private __gap;
}
