// SPDX-License-Identifier: GPL
pragma solidity ^0.6.6;

import "./interfaces/IOneSwapToken.sol";


abstract contract OneSwapBlackList is IOneSwapBlackList {
    address private _owner;
    mapping(address => bool) private _isBlackListed;

    constructor() public {
        _owner = msg.sender;
    }

    
    
    modifier onlyOwner() {
        require(msg.sender == _owner, "msg.sender is not owner");
        _;
    }

    

    

    function removeBlackLists(address[] calldata _clearedUser) public override onlyOwner {
        for (uint i = 0; i < _clearedUser.length; i++) {
            delete _isBlackListed[_clearedUser[i]];
        }
        emit RemovedBlackLists(_clearedUser);
    }

    function _setOwner(address newOwner) internal {
        if (newOwner != address(0)) {
            _owner = newOwner;
            emit OwnerChanged(newOwner);
        }
    }
}
