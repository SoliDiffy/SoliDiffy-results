// SPDX-License-Identifier: MIT

pragma solidity 0.7.6;
pragma abicoder v2;

import '@openzeppelin/contracts/token/ERC20/IERC20.sol';
import '../../interfaces/IAToken.sol';
import '../../interfaces/ILendingPool.sol';
import '../../interfaces/IPositionManager.sol';
import '../../interfaces/actions/IAaveDeposit.sol';
import '../utils/Storage.sol';

///@notice action to deposit tokens into aave protocol
contract AaveDeposit is IAaveDeposit {
    ///@notice emitted when a deposit on aave is made
    ///@param positionManager address of aave positionManager which deposited
    ///@param token token address
    ///@param id aave position id
    ///@param shares shares emitted
    event DepositedOnAave(address indexed positionManager, address token, uint256 id, uint256 shares);

    ///@notice deposit to aave some token amount
    ///@param token token address
    ///@param amount amount to deposit
    ///@return id of the deposited position
    ///@return shares emitted
    

    function _updateAavePosition(address token, uint256 shares) internal returns (uint256) {
        StorageStruct storage Storage = PositionManagerStorage.getStorage();
        Storage.aaveUserReserves[token].positionShares[Storage.aaveIdCounter] = shares;
        Storage.aaveUserReserves[token].sharesEmitted += shares;
        Storage.aaveIdCounter++;
        return Storage.aaveIdCounter - 1;
    }
}
