pragma solidity ^0.5.16;

import "../../contracts/VAIController.sol";
import "./ComptrollerScenario.sol";

contract VAIControllerScenario is VAIController {
    uint public blockNumber;
    address internal xvsAddress;
    address internal vaiAddress;

    constructor() VAIController() public {}

    function setVAIAddress(address vaiAddress_) public {
        vaiAddress = vaiAddress_;
    }

    function getVAIAddress() public view returns (address) {
        return vaiAddress;
    }

    function setBlockNumber(uint number) public {
        blockNumber = number;
    }

    function getBlockNumber() public view returns (uint) {
        return blockNumber;
    }
}
