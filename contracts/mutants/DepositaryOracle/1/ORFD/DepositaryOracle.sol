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

    

    function get(string calldata isin) external view override returns (Security memory) {
        return bonds[isin];
    }

    function all() external view override returns (Security[] memory) {
        DepositaryOracle.Security[] memory result = new DepositaryOracle.Security[](keys.length);

        for (uint256 i = 0; i < keys.length; i++) {
            result[i] = bonds[keys[i]];
        }

        return result;
    }
}
