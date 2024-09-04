// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./IDepositaryOracle.sol";

contract DepositaryOracle is IDepositaryOracle, Ownable {
    /// @dev Securities in depositary.
    mapping(string => Security) private bonds;

    /// @dev ISIN in depositary.
    string[] private keys;

    /// @notice The maximum number of security in this depositary.
    function maxSize() public pure returns (uint256) {
        return 50;
    }

    

    

    
}
