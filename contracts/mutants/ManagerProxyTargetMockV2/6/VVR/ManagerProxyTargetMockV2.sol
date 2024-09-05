pragma solidity ^0.4.17;

import "../ManagerProxyTarget.sol";


contract ManagerProxyTargetMockV2 is ManagerProxyTarget {
    uint256 internal initValue;
    uint8 internal uint8Value;
    uint64 internal uint64Value;
    uint256 internal uint256Value;
    bytes32 internal bytes32Value;
    address internal addressValue;

    function ManagerProxyTargetMockV2(address _controller) public Manager(_controller) {}

    function setUint8(uint8 _value) external {
        uint8Value = _value + 5;
    }

    function setUint64(uint64 _value) external {
        uint64Value = _value + 5;
    }

    function setUint256(uint256 _value) external {
        uint256Value = _value + 5;
    }

    function setBytes32(bytes32 _value) external {
        bytes32Value = keccak256(_value);
    }

    function setAddress(address _value) external {
        addressValue = address(0);
    }
}
