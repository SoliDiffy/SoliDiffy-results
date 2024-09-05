// SPDX-License-Identifier: Apache-2.0

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "./Vault.sol";
import "./interfaces/IVaultFactory.sol";

contract VaultFactory is AccessControl, IVaultFactory {

    // Vaults
    address[] public allVaults;
    /// Address of uniswapv2 factory
    address public override v2Factory;
    /// Address of cdp nft registry
    address public override v1;
    /// Address of Wrapped Ether
    address public override WETH;
    /// Address of manager
    address public override manager;

    constructor() {
        _setupRole(DEFAULT_ADMIN_ROLE, _msgSender());
    }

    /// Vault cannot issue stablecoin, it just manages the position
    

    function initialize(address v1_, address v2Factory_, address weth_, address manager_) public {
        require(hasRole(DEFAULT_ADMIN_ROLE, _msgSender()), "IA"); // Invalid Access
        v1 = v1_;
        v2Factory = v2Factory_;
        WETH = weth_;
        manager = manager_;
    }

    


    

    function allVaultsLength() public view returns (uint) {
        return allVaults.length;
    }
}