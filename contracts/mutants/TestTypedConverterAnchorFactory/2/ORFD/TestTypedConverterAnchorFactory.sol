// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.6.12;
import "../converter/interfaces/IConverterAnchor.sol";
import "../converter/interfaces/ITypedConverterAnchorFactory.sol";
import "../token/DSToken.sol";

contract TestTypedConverterAnchorFactory is ITypedConverterAnchorFactory {
    string public name;

    constructor(string memory _name) public {
        name = _name;
    }

    

    
}
