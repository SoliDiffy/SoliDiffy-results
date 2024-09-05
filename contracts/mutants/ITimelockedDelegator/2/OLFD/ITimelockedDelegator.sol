// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../token/IFei.sol";

interface ITribe is IERC20 {
    
}

/// @title TimelockedDelegator interface
/// @author Fei Protocol
interface ITimelockedDelegator {
    // ----------- Events -----------

    event Delegate(address indexed _delegatee, uint256 _amount);

    event Undelegate(address indexed _delegatee, uint256 _amount);

    // ----------- Beneficiary only state changing api -----------

    

    function undelegate(address delegatee) external returns (uint256);

    // ----------- Getters -----------

    function delegateContract(address delegatee)
        external
        view
        returns (address);

    function delegateAmount(address delegatee) external view returns (uint256);

    function totalDelegated() external view returns (uint256);

    function tribe() external view returns (ITribe);
}
