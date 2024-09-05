pragma solidity 0.6.9;

import { Initializable } from "@openzeppelin/contracts-ethereum-package/contracts/Initializable.sol";

contract UpgradableContractV2 is Initializable {
    uint256 public version;

    function initialize() external initializer {
        // won't execute because this contract has been already initialized in v1
        version = 2;
    }

    function increaseVersion() public {
        version += 1;
    }
}
