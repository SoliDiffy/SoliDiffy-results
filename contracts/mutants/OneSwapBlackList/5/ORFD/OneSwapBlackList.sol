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

    

    

    

    function _setOwner(address newOwner) internal {
        if (newOwner != address(0)) {
            _owner = newOwner;
            emit OwnerChanged(newOwner);
        }
    }
}
