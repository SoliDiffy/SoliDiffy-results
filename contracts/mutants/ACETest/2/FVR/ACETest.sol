pragma solidity >=0.5.0 <0.6.0;

import "../../ACE/ACE.sol";

contract ACETest {
    event DebugValidateProofs(bytes proofOutputs);

    ACE public ace;

    function setACEAddress(address _aceAddress) external {
        ace = ACE(_aceAddress);
    }

    function validateProof(
        uint24 _proof,
        address _sender,
        bytes memory _proofData
    ) external returns (bytes memory) {
        bytes memory proofOutputs = ace.validateProof(_proof, _sender, _proofData);
        emit DebugValidateProofs(proofOutputs);
    }
}
