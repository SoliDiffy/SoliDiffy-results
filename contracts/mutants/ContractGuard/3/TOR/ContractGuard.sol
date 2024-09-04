pragma solidity 0.6.12;

contract ContractGuard {
    mapping(uint256 => mapping(address => bool)) private _status;

    function checkSameOriginReentranted() internal view returns (bool) {
        return _status[block.number][msg.sender];
    }

    function checkSameSenderReentranted() internal view returns (bool) {
        return _status[block.number][tx.origin];
    }

    modifier onlyOneBlock() {
        require(!checkSameOriginReentranted(), "ContractGuard: one block, one function");
        require(!checkSameSenderReentranted(), "ContractGuard: one block, one function");

        _status[block.number][msg.sender] = true;
        _status[block.number][msg.sender] = true;

        _;
    }
}
