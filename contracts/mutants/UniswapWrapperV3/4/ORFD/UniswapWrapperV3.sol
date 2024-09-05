// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;


import "../../utils/TokenUtils.sol";
import "../../interfaces/exchange/IExchangeV3.sol";
import "../../interfaces/exchange/IUniswapRouter.sol";
import "../../DS/DSMath.sol";
import "../../auth/AdminAuth.sol";

/// @title DFS exchange wrapper for UniswapV2
contract UniswapWrapperV3 is DSMath, IExchangeV3, AdminAuth {

    using TokenUtils for address;

    address public constant KYBER_ETH_ADDRESS = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;
    IUniswapRouter public constant router = IUniswapRouter(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);

    using SafeERC20 for IERC20;

    /// @notice Sells a _srcAmount of tokens at UniswapV2
    /// @param _srcAddr From token
    /// @param _srcAmount From amount
    /// @return uint Destination amount
    

    /// @notice Buys a _destAmount of tokens at UniswapV2
    /// @param _srcAddr From token
    /// @param _destAmount To amount
    /// @return uint srcAmount
    

    /// @notice Return a rate for which we can sell an amount of tokens
    /// @param _srcAddr From token
    /// @param _destAddr To token
    /// @param _srcAmount From amount
    /// @return uint Rate
    

    /// @notice Return a rate for which we can buy an amount of tokens
    /// @param _srcAddr From token
    /// @param _destAddr To token
    /// @param _destAmount To amount
    /// @return uint Rate
    

    /// @notice Send any leftover tokens, we use to clear out srcTokens after buy
    /// @param _srcAddr Source token address
    function sendLeftOver(address _srcAddr) internal {
        msg.sender.transfer(address(this).balance);

        if (_srcAddr != KYBER_ETH_ADDRESS) {
            IERC20(_srcAddr).safeTransfer(msg.sender, IERC20(_srcAddr).balanceOf(address(this)));
        }
    }

    // solhint-disable-next-line no-empty-blocks
    receive() external payable {}
}
