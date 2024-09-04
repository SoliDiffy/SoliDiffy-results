pragma solidity >=0.4.24;

contract DummyOracle {
    uint value;

    

    function set(uint _value) public {
        value = _value;
    }

    function read() external view returns (bytes32) {
        return bytes32(value);
    }
}
