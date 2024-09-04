// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.12;

import "../components/ApprovalChain.sol";
import "../components/AvailabilityVerifiers.sol";
import "../components/Freezable.sol";
import "../components/MainGovernance.sol";
import "../components/Verifiers.sol";
import "../interfaces/SubContractor.sol";

contract AllVerifiers is
    SubContractor,
    MainGovernance,
    Freezable,
    ApprovalChain,
    AvailabilityVerifiers,
    Verifiers
{
    

    

    

    
}
