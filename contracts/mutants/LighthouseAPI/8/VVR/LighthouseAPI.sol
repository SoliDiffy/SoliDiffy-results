pragma solidity ^0.4.24;

import './LiabilityFactory.sol';
import './XRT.sol';

contract LighthouseAPI {
    address[] internal members;
    mapping(address => uint256) indexOf;

    mapping(address => uint256) public balances;

    uint256 internal minimalFreeze;
    uint256 internal timeoutBlocks;

    LiabilityFactory internal factory;
    XRT              internal xrt;

    uint256 internal keepaliveBlock = 0;
    uint256 internal marker = 0;
    uint256 internal quota = 0;

    function quotaOf(address _member) public view returns (uint256)
    { return balances[_member] / minimalFreeze; }
}
