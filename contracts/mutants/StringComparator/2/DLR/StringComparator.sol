pragma solidity 0.5.10;

library StringComparator {
    function compareStrings (string storage a, string storage b) public pure
       returns (bool) {
        return keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked((b)));
    }
}
