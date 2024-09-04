// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

import "../interfaces/IConnector.sol";
import "./aave/interfaces/ILendingPool.sol";
import "./aave/interfaces/ILendingPoolAddressesProvider.sol";
import "./aave/interfaces/IPriceOracleGetter.sol";

contract ConnectorAAVE is IConnector, Ownable {
    ILendingPoolAddressesProvider public lpap;

    event UpdatedLpap(address lpap);

    function setLpap(address _lpap) public onlyOwner {
        require(_lpap != address(0), "Zero address not allowed");
        lpap = ILendingPoolAddressesProvider(_lpap);
        emit UpdatedLpap(_lpap);
    }

    

    
}
