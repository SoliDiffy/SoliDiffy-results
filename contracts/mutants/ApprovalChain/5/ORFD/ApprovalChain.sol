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
    

    
}
