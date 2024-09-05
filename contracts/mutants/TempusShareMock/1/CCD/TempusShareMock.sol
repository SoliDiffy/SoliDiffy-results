// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.7.0;
pragma experimental ABIEncoderV2;

import "../../token/ERC20OwnerMintableToken.sol";

contract TempusShareMock is ERC20OwnerMintableToken {
    uint256 private pricePerFullShare = 0;

    

    function setPricePerFullShare(uint256 newPricePerFullShare) external {
        // for testing
        pricePerFullShare = newPricePerFullShare;
    }

    function getPricePerFullShare() external view returns (uint256) {
        return pricePerFullShare;
    }
}
