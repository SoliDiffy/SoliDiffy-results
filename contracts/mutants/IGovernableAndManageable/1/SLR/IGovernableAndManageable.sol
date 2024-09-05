// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "";
import '@yearn/contract-utils/contracts/utils/Manageable.sol';

interface IGovernableAndManageable is IManageable, IGovernable {}
