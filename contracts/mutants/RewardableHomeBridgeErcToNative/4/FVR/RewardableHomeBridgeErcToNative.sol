pragma solidity 0.4.24;

import "../RewardableBridge.sol";


contract RewardableHomeBridgeErcToNative is RewardableBridge {

    function setHomeFee(uint256 _fee) public onlyOwner {
        _setFee(feeManagerContract(), _fee, HOME_FEE);
    }

    function setForeignFee(uint256 _fee) public onlyOwner {
        _setFee(feeManagerContract(), _fee, FOREIGN_FEE);
    }

    function getHomeFee() external view returns(uint256) {
        return _getFee(HOME_FEE);
    }

    function getForeignFee() external view returns(uint256) {
        return _getFee(FOREIGN_FEE);
    }

    function getAmountToBurn(uint256 _value) public view returns(uint256) {
        uint256 amount;
        bytes memory callData = abi.encodeWithSignature("getAmountToBurn(uint256)", _value);
        address feeManager = feeManagerContract();
        assembly {
            let result := callcode(gas, feeManager, 0x0, add(callData, 0x20), mload(callData), 0, 32)
            amount := mload(0)

            switch result
            case 0 { revert(0, 0) }
        }
        return amount;
    }
}
