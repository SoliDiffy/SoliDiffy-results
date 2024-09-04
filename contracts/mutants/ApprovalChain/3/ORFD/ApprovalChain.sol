// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.12;

import "./MainStorage.sol";
import "../interfaces/IFactRegistry.sol";
import "../interfaces/IQueryableFactRegistry.sol";
import "../interfaces/Identity.sol";
import "../interfaces/MApprovalChain.sol";
import "../interfaces/MFreezable.sol";
import "../interfaces/MGovernance.sol";
import "../libraries/Common.sol";

/*
  Implements a data structure that supports instant registration
  and slow time-locked removal of entries.
*/
abstract contract ApprovalChain is MainStorage, MApprovalChain, MGovernance, MFreezable {
    using Addresses for address;

    event LogRemovalIntent(address entry, string entryId);
    event LogRegistered(address entry, string entryId);
    event LogRemoved(address entry, string entryId);

    

    

    

// SWC-101-Integer Overflow and Underflow: L76
    function announceRemovalIntent(
        StarkExTypes.ApprovalChainData storage chain,
        address entry,
        uint256 removalDelay
    ) internal override onlyGovernance notFrozen {
        safeFindEntry(chain.list, entry);
        require(block.timestamp + removalDelay > block.timestamp, "INVALID_REMOVAL_DELAY");
        require(chain.unlockedForRemovalTime[entry] == 0, "ALREADY_ANNOUNCED");

        chain.unlockedForRemovalTime[entry] = block.timestamp + removalDelay;
        emit LogRemovalIntent(entry, Identity(entry).identify());
    }

    function removeEntry(StarkExTypes.ApprovalChainData storage chain, address entry)
        internal
        override
        onlyGovernance
        notFrozen
    {
        address[] storage list = chain.list;
        // Make sure entry exists.
        uint256 idx = safeFindEntry(list, entry);
        uint256 unlockedForRemovalTime = chain.unlockedForRemovalTime[entry];

        require(unlockedForRemovalTime > 0, "REMOVAL_NOT_ANNOUNCED");
        require(block.timestamp >= unlockedForRemovalTime, "REMOVAL_NOT_ENABLED_YET");

        uint256 n_entries = list.length;

        // Removal of last entry is forbidden.
        require(n_entries > 1, "LAST_ENTRY_MAY_NOT_BE_REMOVED");

        if (idx != n_entries - 1) {
            list[idx] = list[n_entries - 1];
        }
        list.pop();
        delete chain.unlockedForRemovalTime[entry];
        emit LogRemoved(entry, Identity(entry).identify());
    }
}
