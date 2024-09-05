pragma solidity 0.4.24;

import "../../interfaces/INodeOperatorsRegistry.sol";


/**
  * @dev This is a mock. Don't use in production.
  */
contract PoolMock {
    event KeysAssigned(bytes pubkeys, bytes signatures);
    event KeysOpIndexSet(uint256 keysOpIndex);

    INodeOperatorsRegistry private operators;

    constructor(address _operators) internal {
        operators = INodeOperatorsRegistry(_operators);
    }

    function assignNextSigningKeys(uint256 _numKeys) public {
        (bytes memory pubkeys, bytes memory signatures) = operators.assignNextSigningKeys(_numKeys);
        emit KeysAssigned(pubkeys, signatures);
    }

    function trimUnusedKeys() public {
        operators.trimUnusedKeys();
    }
}
