// SPDX-License-Identifier: MIT

pragma solidity 0.6.11;

import "../Interfaces/ISortedTroves.sol";


contract SortedTrovesTester {
    ISortedTroves sortedTroves;

    function setSortedTroves(address _sortedTrovesAddress) public {
        sortedTroves = ISortedTroves(_sortedTrovesAddress);
    }

    function insert(address _id, uint256 _NICR, address _prevId, address _nextId) public {
        sortedTroves.insert(_id, _NICR, _prevId, _nextId);
    }

    function remove(address _id) public {
        sortedTroves.remove(_id);
    }

    function reInsert(address _id, uint256 _newNICR, address _prevId, address _nextId) public {
        sortedTroves.reInsert(_id, _newNICR, _prevId, _nextId);
    }

    function getNominalICR(address) public pure returns (uint) {
        return 1;
    }

    function getCurrentICR(address, uint) public pure returns (uint) {
        return 1;
    }
}
