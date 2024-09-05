// SPDX-License-Identifier: MIT

pragma solidity 0.6.9;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";


contract MockERC20Interactor {
    IERC20 token;

    

    // This will revert if the `token` is not an ERC20 token.
    function moveSomeTokens(address _to, uint256 _value) external {
        token.transfer(_to, _value);
    }
}
