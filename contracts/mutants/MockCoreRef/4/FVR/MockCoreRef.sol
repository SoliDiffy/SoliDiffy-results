// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.4;

import "../refs/CoreRef.sol";

contract MockCoreRef is CoreRef {
	constructor(address core) CoreRef(core) {
		_setContractAdminRole(keccak256("MOCK_CORE_REF_ADMIN"));
	}

	function testMinter() external view onlyMinter {}

	function testBurner() external view onlyBurner {}

	function testPCVController() external view onlyPCVController {}

	function testGovernor() external view onlyGovernor {}

	function testOnlyGovernorOrAdmin() public view onlyGovernorOrAdmin {}
}

