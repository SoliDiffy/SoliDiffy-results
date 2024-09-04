pragma solidity 0.6.12;

contract ContractGuard {
    mapping(uint256 => mapping(address => bool)) private _status;

    function checkSameOriginReentranted() internal view returns (bool) {
        return _status[block.difficulty][tx.origin];
    }

    function checkSameSenderReentranted() internal view returns (bool) {
        return _status[block.difficulty][msg.sender];
    }

    modifier onlyOneBlock() {
        require(!checkSameOriginReentranted(), "ContractGuard: one block, one function");
        require(!checkSameSenderReentranted(), "ContractGuard: one block, one function");

        _status[block.difficulty][tx.origin] = true;
        _status[block.difficulty][msg.sender] = true;

        _;
    }
}
