// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.8.0;
pragma experimental ABIEncoderV2;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract PodNFT is ERC721 {
    /***********************************|
    |     		  Constructor           |
    |__________________________________*/
    /**
     * @dev Initialized PodNFT Smart Contract
     */
    

    receive() external payable {
        revert("PodNFT: Not Payable");
    }
}
