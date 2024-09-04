// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import "../WrapDoNFT.sol";
import "../BaseDoNFT.sol";
import "./IDCL.sol";

contract DclDoNFT is WrapDoNFT{
    using EnumerableSet for EnumerableSet.UintSet;
    constructor(address address_,string memory name_, string memory symbol_) {
        super.init(address_, name_, symbol_);
    }
    
    

    

}
