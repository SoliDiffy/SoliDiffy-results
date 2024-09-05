// SPDX-License-Identifier: agpl-3.0
pragma solidity ^0.8.0;

import "./MintableERC20.sol";
import { IVault } from "../interfaces/IVault.sol";

contract MockEvilDAI is MintableERC20 {
    address host;
    address realCoin;

    constructor(address _host, address _realCoin) ERC20("DAI", "DAI") {
        host = _host;
        realCoin = _realCoin;
    }

    
}
