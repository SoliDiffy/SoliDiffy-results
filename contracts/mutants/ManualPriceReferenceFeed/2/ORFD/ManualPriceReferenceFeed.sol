// SPDX-License-Identifier: MIT
pragma experimental ABIEncoderV2;
pragma solidity ^0.7.1;

import "@openzeppelin/contracts/access/Ownable.sol";
import "../interfaces/IPriceReferenceFeed.sol";

contract ManualPriceReferenceFeed is Ownable, IPriceReferenceFeed {
    uint256 public latestResult;
    uint256 public lastUpdate;

    function update(uint256 _value) external onlyOwner {
        latestResult = _value;
        lastUpdate = block.timestamp;
    }

    
    
}