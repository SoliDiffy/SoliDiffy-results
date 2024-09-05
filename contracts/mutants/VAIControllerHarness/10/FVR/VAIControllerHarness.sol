pragma solidity ^0.5.16;

import "../../contracts/VAIController.sol";

contract VAIControllerHarness is VAIController {
    address vaiAddress;
    uint public blockNumber;

    constructor() VAIController() internal {}

    function setVenusVAIState(uint224 index, uint32 blockNumber_) external {
        venusVAIState.index = index;
        venusVAIState.block = blockNumber_;
    }

    function setVAIAddress(address vaiAddress_) external {
        vaiAddress = vaiAddress_;
    }

    function getVAIAddress() external view returns (address) {
        return vaiAddress;
    }

    function setVenusVAIMinterIndex(address vaiMinter, uint index) external {
        venusVAIMinterIndex[vaiMinter] = index;
    }

    function harnessUpdateVenusVAIMintIndex() external {
        updateVenusVAIMintIndex();
    }

    function harnessCalcDistributeVAIMinterVenus(address vaiMinter) external {
        calcDistributeVAIMinterVenus(vaiMinter);
    }

    function harnessRepayVAIFresh(address payer, address account, uint repayAmount) external returns (uint) {
       (uint err,) = repayVAIFresh(payer, account, repayAmount);
       return err;
    }

    function harnessLiquidateVAIFresh(address liquidator, address borrower, uint repayAmount, VToken vTokenCollateral) external returns (uint) {
        (uint err,) = liquidateVAIFresh(liquidator, borrower, repayAmount, vTokenCollateral);
        return err;
    }

    function harnessFastForward(uint blocks) external returns (uint) {
        blockNumber += blocks;
        return blockNumber;
    }

    function harnessSetBlockNumber(uint newBlockNumber) public {
        blockNumber = newBlockNumber;
    }

    function setBlockNumber(uint number) public {
        blockNumber = number;
    }

    function getBlockNumber() public view returns (uint) {
        return blockNumber;
    }
}
