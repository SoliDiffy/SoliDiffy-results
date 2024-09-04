pragma solidity 0.4.24;

import "../../IBlockReward.sol";
import "../Sacrifice.sol";
import "../ValidatorsFeeManager.sol";


contract FeeManagerErcToNative is ValidatorsFeeManager {

    function getFeeManagerMode() external pure returns(bytes4) {
        return bytes4(keccak256(abi.encodePacked("manages-both-directions")));
    }

    function blockRewardContract() public view returns(IBlockReward) {
        return IBlockReward(addressStorage[keccak256(abi.encodePacked("blockRewardContract"))]);
    }

    function onAffirmationFeeDistribution(address _rewardAddress, uint256 _fee) public {
        IBlockReward blockReward = blockRewardContract();
        blockReward.addExtraReceiver(_fee, _rewardAddress);
    }

    function onSignatureFeeDistribution(address _rewardAddress, uint256 _fee) public {
        if (!_rewardAddress.send(_fee)) {
            (new Sacrifice).value(_fee)(_rewardAddress);
        }
    }

    function getAmountToBurn(uint256 _value) public view returns(uint256) {
        uint256 fee = calculateFee(_value, false, HOME_FEE);
        return _value.sub(fee);
    }
}
