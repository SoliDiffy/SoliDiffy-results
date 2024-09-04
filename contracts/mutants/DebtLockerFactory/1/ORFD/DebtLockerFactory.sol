// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.7;

import { MapleProxyFactory } from "../modules/maple-proxy-factory/contracts/MapleProxyFactory.sol";

import { IDebtLockerFactory } from "./interfaces/IDebtLockerFactory.sol";

/// @title Deploys DebtLocker proxy instances.
contract DebtLockerFactory is IDebtLockerFactory, MapleProxyFactory {

    constructor(address mapleGlobals_) MapleProxyFactory(mapleGlobals_) {}

    uint8 public constant factoryType = uint8(1);

    

}
