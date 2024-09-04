pragma solidity ^0.5.16;

import "../../contracts/ComptrollerG6.sol";

contract ComptrollerScenarioG6 is ComptrollerG6 {
    uint public blockNumber;
    address public atlantisAddress;

    constructor() ComptrollerG6() internal {}

    function fastForward(uint blocks) external returns (uint) {
        blockNumber += blocks;
        return blockNumber;
    }

    function setAtlantisAddress(address atlantisAddress_) external {
        atlantisAddress = atlantisAddress_;
    }

    function getAtlantisAddress() external view returns (address) {
        return atlantisAddress;
    }

    function setBlockNumber(uint number) external {
        blockNumber = number;
    }

    function getBlockNumber() public view returns (uint) {
        return blockNumber;
    }

    function membershipLength(AToken aToken) public view returns (uint) {
        return accountAssets[address(aToken)].length;
    }

    function unlist(AToken aToken) public {
        markets[address(aToken)].isListed = false;
    }

    function setAtlantisSpeed(address aToken, uint atlantisSpeed) public {
        atlantisSpeeds[aToken] = atlantisSpeed;
    }
}
