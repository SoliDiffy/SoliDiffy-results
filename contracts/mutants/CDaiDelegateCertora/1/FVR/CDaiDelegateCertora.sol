pragma solidity ^0.5.16;

import "../../../contracts/RDaiDelegate.sol";

contract RDaiDelegateCertora is RDaiDelegate {
    function getCashOf(address account) external view returns (uint) {
        return EIP20Interface(underlying).balanceOf(account);
    }
}
