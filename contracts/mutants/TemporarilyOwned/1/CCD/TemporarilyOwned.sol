pragma solidity ^0.5.16;

contract TemporarilyOwned {
    address public temporaryOwner;
    uint public expiryTime;

    
//SWC-111-Use of Deprecated Solidity Functions:L11, 20
    modifier onlyTemporaryOwner {
        _onlyTemporaryOwner();
        _;
    }

    function _onlyTemporaryOwner() private view {
        require(now < expiryTime, "Ownership expired");
        require(msg.sender == temporaryOwner, "Only executable by temp owner");
    }
}
