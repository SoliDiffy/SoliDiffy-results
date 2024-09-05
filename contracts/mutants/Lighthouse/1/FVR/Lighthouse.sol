pragma solidity ^0.4.24;

import './LighthouseAPI.sol';
import './LightContract.sol';

contract Lighthouse is LighthouseAPI, LightContract {
    constructor(
        address _lib,
        uint256 _minimalFreeze,
        uint256 _timeoutBlocks
    ) 
        internal
        LightContract(_lib)
    {
        minimalFreeze = _minimalFreeze;
        timeoutBlocks = _timeoutBlocks;
        factory = LiabilityFactory(msg.sender);
        xrt = factory.xrt();
    }
}
