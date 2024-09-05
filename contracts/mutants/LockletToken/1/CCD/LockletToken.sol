// contracts/LockletToken.sol
// SPDX-License-Identifier: No License
// SWC-103-Floating Pragma: L4
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract LockletToken is ERC20 {
    uint256 private _initialSupply;
    uint256 private _totalSupply;

    

    function burn(uint256 amount) external returns (bool) {
        _burn(msg.sender, amount);
        return true;
    }
}
