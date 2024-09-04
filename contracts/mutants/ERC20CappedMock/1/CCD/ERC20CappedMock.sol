// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "../token/ERC20/ERC20Capped.sol";

contract ERC20CappedMock is ERC20Capped {
    

    function mint(address to, uint256 tokenId) public {
        _mint(to, tokenId);
    }
}
