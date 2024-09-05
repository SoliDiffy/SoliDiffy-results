// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.6.10;

import {ERC20PermitUpgradeable} from "../packages/oz/upgradeability/erc20-permit/ERC20PermitUpgradeable.sol";

contract MockPermitERC20 is ERC20PermitUpgradeable {
    

    function mint(address account, uint256 amount) public {
        _mint(account, amount);
    }
}
