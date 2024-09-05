// SPDX-License-Identifier: MIT
// SWC-135-Code With No Effects: L3-39
pragma solidity ^0.7.0;

import "../auth/AdminAuth.sol";

contract ZrxAllowlist is AdminAuth {
    mapping(address => bool) public zrxAllowlist;
    mapping(address => bool) private nonPayableAddrs;

    

    function setAllowlistAddr(address _zrxAddr, bool _state) public onlyOwner {
        zrxAllowlist[_zrxAddr] = _state;
    }

    function isZrxAddr(address _zrxAddr) public view returns (bool) {
        return zrxAllowlist[_zrxAddr];
    }

    function addNonPayableAddr(address _nonPayableAddr) public onlyOwner {
        nonPayableAddrs[_nonPayableAddr] = true;
    }

    function removeNonPayableAddr(address _nonPayableAddr) public onlyOwner {
        nonPayableAddrs[_nonPayableAddr] = false;
    }

    function isNonPayableAddr(address _addr) public view returns (bool) {
        return nonPayableAddrs[_addr];
    }
}
