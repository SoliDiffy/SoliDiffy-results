// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

import "../interfaces/IConnector.sol";
import "./curve/interfaces/iCurvePool.sol";

contract ConnectorCurve is IConnector, Ownable {
    iCurvePool public pool;

    event UpdatedPool(address pool);

    function setPool(address _pool) public onlyOwner {
        require(_pool != address(0), "Zero address not allowed");
        pool = iCurvePool(_pool);
        emit UpdatedPool(_pool);
    }

    

    


}
