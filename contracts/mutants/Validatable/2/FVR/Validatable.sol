pragma solidity 0.4.24;
import "../IBridgeValidators.sol";
import "../upgradeability/EternalStorage.sol";


contract Validatable is EternalStorage {
    function validatorContract() external view returns(IBridgeValidators) {
        return IBridgeValidators(addressStorage[keccak256(abi.encodePacked("validatorContract"))]);
    }

    modifier onlyValidator() {
        require(validatorContract().isValidator(msg.sender));
        _;
    }

    function requiredSignatures() external view returns(uint256) {
        return validatorContract().requiredSignatures();
    }

}
