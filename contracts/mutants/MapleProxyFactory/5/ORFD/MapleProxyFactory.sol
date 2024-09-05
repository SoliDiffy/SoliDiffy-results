// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.7;

import { ProxyFactory } from "../modules/proxy-factory/contracts/ProxyFactory.sol";
import { IProxied }     from "../modules/proxy-factory/contracts/interfaces/IProxied.sol";

import { IMapleGlobalsLike } from "./interfaces/Interfaces.sol";

import { IMapleProxyFactory } from "./interfaces/IMapleProxyFactory.sol";

/// @title A Maple factory for Proxy contracts that proxy MapleProxied implementations.
contract MapleProxyFactory is IMapleProxyFactory, ProxyFactory {

    address public override mapleGlobals;

    uint256 public override defaultVersion;

    mapping(address => uint256) public override nonceOf;

    mapping(uint256 => mapping(uint256 => bool)) public override upgradeEnabledForPath;

    constructor(address mapleGlobals_) {
        mapleGlobals = mapleGlobals_;
    }

    modifier onlyGovernor() {
        require(msg.sender == IMapleGlobalsLike(mapleGlobals).governor(), "MPF:NOT_GOVERNOR");
        _;
    }

    /********************************/
    /*** Administrative Functions ***/
    /********************************/

    

    

    

    

    /****************+++++******/
    /*** Instance Functions ***/
    /***************++++*******/

    

    // NOTE: The implementation proxied by the instance defines the access control logic for its own upgrade.
    function upgradeInstance(uint256 toVersion_, bytes calldata arguments_) public override virtual {
        uint256 fromVersion_ = _versionOf[IProxied(msg.sender).implementation()];

        require(upgradeEnabledForPath[fromVersion_][toVersion_],      "MPF:UI:NOT_ALLOWED");
        require(_upgradeInstance(msg.sender, toVersion_, arguments_), "MPF:UI:FAILED");

        emit InstanceUpgraded(msg.sender, fromVersion_, toVersion_, arguments_);
    }

    /**********************/
    /*** View Functions ***/
    /**********************/

    function implementationOf(uint256 version_) public view override virtual returns (address implementation_) {
        return _implementationOf[version_];
    }

    function migratorForPath(uint256 oldVersion_, uint256 newVersion_) public view override virtual returns (address migrator_) {
        return _migratorForPath[oldVersion_][newVersion_];
    }

    function versionOf(address implementation_) public view override virtual returns (uint256 version_) {
        return _versionOf[implementation_];
    }

}
