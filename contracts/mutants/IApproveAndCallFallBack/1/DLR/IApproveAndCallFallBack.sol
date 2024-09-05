pragma solidity ^0.5.0;

contract IApproveAndCallFallBack {
    function receiveApproval(
        address from,
        uint256 amount_,
        address token_,
        bytes storage data_
    ) public;
}
