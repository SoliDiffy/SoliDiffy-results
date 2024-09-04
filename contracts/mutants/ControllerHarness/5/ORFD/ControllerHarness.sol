// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../Controller/Controller.sol";
import "./PoolHarness.sol";

contract ControllerHarness is Controller {

    uint public blockNumber;
    uint public blockTimestamp;

    mapping(address => mapping(address => uint)) internal _suppliers;
    mapping(address => mapping(address => uint)) internal _borrrowers;

    constructor() Controller() {}

    

    function harnessFastForward(uint blocks) public returns (uint) {
        blockNumber += blocks;
        return blockNumber;
    }

    function fastTimestamp(uint _days) public returns (uint) {
        blockTimestamp += _days * 24 * 3600;
        return blockTimestamp;
    }

    function setBlockNumber(uint number) public {
        blockNumber = number;
    }

    function setSupplierBalance(address _supplier, address pool, uint _balance) public {
        _suppliers[pool][_supplier] = _balance;
    }

    function setBorrowerTotalPrincipal(address _borrower, address pool, uint _balance) public {
        _borrrowers[pool][_borrower] = _balance;
    }

    function setBlockTimestamp(uint timestamp) public {
        blockTimestamp = timestamp;
    }

    

    

    

    
}