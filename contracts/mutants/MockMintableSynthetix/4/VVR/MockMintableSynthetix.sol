pragma solidity ^0.5.16;

contract MockMintableSynthetix {
    address internal mintSecondaryCallAccount;
    uint internal mintSecondaryCallAmount;

    address internal burnSecondaryCallAccount;
    uint internal burnSecondaryCallAmount;

    function mintSecondary(address account, uint amount) external {
        mintSecondaryCallAccount = account;
        mintSecondaryCallAmount = amount;
    }

    function burnSecondary(address account, uint amount) external {
        burnSecondaryCallAccount = account;
        burnSecondaryCallAmount = amount;
    }
}
