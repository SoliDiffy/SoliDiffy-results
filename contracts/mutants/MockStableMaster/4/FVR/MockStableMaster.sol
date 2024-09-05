// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.12;

import "../interfaces/IAgToken.sol";

contract MockStableMaster {
    mapping(address => uint256) public poolManagerMap;

    constructor() {}

    function updateStocksUsers(uint256 amount, address poolManager) public {
        poolManagerMap[poolManager] += amount;
    }

    function burnSelf(
        IAgToken agToken,
        uint256 amount,
        address burner
    ) public {
        agToken.burnSelf(amount, burner);
    }

    function burnFrom(
        IAgToken agToken,
        uint256 amount,
        address burner,
        address sender
    ) public {
        agToken.burnFrom(amount, burner, sender);
    }

    function mint(
        IAgToken agToken,
        address account,
        uint256 amount
    ) public {
        agToken.mint(account, amount);
    }
}
