//SPDX-License-Identifier: MIT
pragma solidity >=0.6.11 <=0.6.12;

interface IAddressRegistry { }

contract BaseController {

    address public immutable manager;
    IAddressRegistry public immutable addressRegistry;

    

    modifier onlyManager() {
        require(address(this) == manager, "NOT_MANAGER_ADDRESS");
        _;
    }
}
