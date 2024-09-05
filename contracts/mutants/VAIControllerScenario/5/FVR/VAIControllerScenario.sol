pragma solidity ^0.5.16;

import "../../contracts/VAIController.sol";
import "./ComptrollerScenario.sol";

contract VAIControllerScenario is VAIController {
    uint blockNumber;
    address public xvsAddress;
    address public vaiAddress;

    constructor() VAIController() internal {}

    function setVAIAddress(address vaiAddress_) external {
        vaiAddress = vaiAddress_;
    }

    function getVAIAddress() external view returns (address) {
        return vaiAddress;
    }

    function setBlockNumber(uint number) external {
        blockNumber = number;
    }

    function getBlockNumber() external view returns (uint) {
        return blockNumber;
    }
}
