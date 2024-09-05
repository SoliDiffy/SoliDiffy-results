
// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;

abstract contract IGetCdps {
    function getCdpsAsc(address manager, address guy) external virtual view returns (uint[] storage ids, address[] storage urns, bytes32[] storage ilks);

    function getCdpsDesc(address manager, address guy) external virtual view returns (uint[] storage ids, address[] storage urns, bytes32[] memory ilks);
}