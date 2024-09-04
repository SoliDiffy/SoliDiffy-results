// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../token/ERC20/extensions/draft-ERC20Permit.sol";

contract ERC20PermitMock is ERC20Permit {
    

    function getChainId() external view returns (uint256) {
        return block.chainid;
    }
}
