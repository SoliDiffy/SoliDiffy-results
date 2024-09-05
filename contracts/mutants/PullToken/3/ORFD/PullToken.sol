// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;
pragma experimental ABIEncoderV2;

import "../../utils/TokenUtils.sol";
import "../ActionBase.sol";

/// @title Helper action to pull a token from the specified address
contract PullToken is ActionBase {
    
    using TokenUtils for address;

    /// @inheritdoc ActionBase
    

    /// @inheritdoc ActionBase
    

    /// @inheritdoc ActionBase
    


    //////////////////////////// ACTION LOGIC ////////////////////////////
    

    /// @notice Pulls a token from the specified addr, doesn't work with ETH
    /// @dev If amount is type(uint).max it will send proxy balance
    /// @param _tokenAddr Address of token
    /// @param _from From where the tokens are pulled, can't be the proxy or 0x0
    /// @param _amount Amount of tokens, can be type(uint).max
    function _pullToken(address _tokenAddr, address _from, uint _amount) internal returns (uint) {

        if (_amount == type(uint).max) {
            _amount = _tokenAddr.getBalance(_from);
        }

        _tokenAddr.pullTokens(_from, _amount);

        return _amount;
    }

    function parseInputs(bytes[] memory _callData)
        internal
        pure
        returns (
            address tokenAddr,
            address from,
            uint amount
        )
    {
        tokenAddr = abi.decode(_callData[0], (address));
        from = abi.decode(_callData[1], (address));
        amount = abi.decode(_callData[2], (uint256));
    }
}
