// "SPDX-License-Identifier: GPL-3.0-or-later"

pragma solidity 0.7.6;

import "./ITokenBuilder.sol";
import "./ERC20PresetMinterPermitted.sol";
import "./IERC20Metadata.sol";
import "../IDerivativeSpecification.sol";
import "./TokenMetadataGenerator.sol";

contract TokenBuilder is ITokenBuilder, TokenMetadataGenerator {
    string public constant PRIMARY_TOKEN_NAME_POSTFIX = " UP";
    string public constant COMPLEMENT_TOKEN_NAME_POSTFIX = " DOWN";
    string public constant PRIMARY_TOKEN_SYMBOL_POSTFIX = "-UP";
    string public constant COMPLEMENT_TOKEN_SYMBOL_POSTFIX = "-DOWN";
    uint8 public constant DECIMALS_DEFAULT = 18;

    event DerivativeTokensCreated(
        address primaryTokenAddress,
        address complementTokenAddress
    );

    

    
}
