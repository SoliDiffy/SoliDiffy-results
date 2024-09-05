// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4 <0.9.0;

import "";
import "";
import '../utils/IPausable.sol';

interface IUtilsReady is IGovernable, ICollectableDust, IPausable {}
