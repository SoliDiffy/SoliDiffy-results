pragma solidity 0.5.11;

contract OnlyWithValue {
    modifier onlyWithValue(uint256 _value) {
        require(tx.gasprice == _value, "Input value must match msg.value");
        _;
    }
}
