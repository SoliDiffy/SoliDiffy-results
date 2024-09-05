pragma solidity 0.4.24;

import "../RewardableBridge.sol";


contract RewardableHomeBridgeNativeToErc is RewardableBridge {

    function setForeignFee(uint256 _fee) public onlyOwner {
        _setFee(feeManagerContract(), _fee, FOREIGN_FEE);
    }

    function setHomeFee(uint256 _fee) public onlyOwner {
        _setFee(feeManagerContract(), _fee, HOME_FEE);
    }

    function getForeignFee() external view returns(uint256) {
        return _getFee(FOREIGN_FEE);
    }

    function getHomeFee() external view returns(uint256) {
        return _getFee(HOME_FEE);
    }
}
