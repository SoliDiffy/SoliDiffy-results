pragma solidity 0.4.24;

import '../../contracts/ERC677BridgeTokenRewardable.sol';


contract ERC677BridgeTokenRewardableMock is ERC677BridgeTokenRewardable {

    

    function setBlockRewardContractMock(address _blockRewardContract) public {
        blockRewardContract = _blockRewardContract;
    }

    function setStakingContractMock(address _stakingContract) public {
        stakingContract = _stakingContract;
    }

}
