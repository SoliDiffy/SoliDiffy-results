// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;
pragma experimental ABIEncoderV2;

import "../../interfaces/uniswap/IUniswapV2Factory.sol";
import "../../interfaces/exchange/IUniswapRouter.sol";
import "../../utils/TokenUtils.sol";
import "../ActionBase.sol";

/// @title Supplies liquidity to uniswap
contract UniSupply is ActionBase {
    using TokenUtils for address;

    IUniswapRouter public constant router =
        IUniswapRouter(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);

    IUniswapV2Factory public constant factory =
        IUniswapV2Factory(0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f);

    struct UniSupplyData {
        address tokenA;
        address tokenB;
        address from;
        address to;
        uint256 amountADesired;
        uint256 amountBDesired;
        uint256 amountAMin;
        uint256 amountBMin;
        uint256 deadline;
    }

    /// @inheritdoc ActionBase
    

    /// @inheritdoc ActionBase
    

    /// @inheritdoc ActionBase
    

    //////////////////////////// ACTION LOGIC ////////////////////////////

    /// @notice Adds liquidity to uniswap and sends lp tokens and returns to _to
    /// @dev Uni markets can move, so extra tokens are expected to be left and are send to _to
    /// @param _uniData All the required data to deposit to uni
    function _uniSupply(UniSupplyData memory _uniData) internal returns (uint256) {
        // fetch tokens from the address
        _uniData.tokenA.pullTokens(_uniData.from, _uniData.amountADesired);
        _uniData.tokenB.pullTokens(_uniData.from, _uniData.amountBDesired);

        // approve router so it can pull tokens
        _uniData.tokenA.approveToken(address(router), _uniData.amountADesired);
        _uniData.tokenB.approveToken(address(router), _uniData.amountBDesired);

        // add liq. and get info how much we put in
        (uint256 amountA, uint256 amountB, uint256 liqAmount) = _addLiquidity(_uniData);

        // send leftovers
        _uniData.tokenA.withdrawTokens(_uniData.to, (_uniData.amountADesired - amountA));
        _uniData.tokenB.withdrawTokens(_uniData.to, (_uniData.amountBDesired - amountB));

        logger.Log(
            address(this),
            msg.sender,
            "UniSupply",
            abi.encode(_uniData, amountA, amountB, liqAmount)
        );

        return liqAmount;
    }

    function _addLiquidity(UniSupplyData memory _uniData)
        internal
        returns (
            uint256 amountA,
            uint256 amountB,
            uint256 liqAmount
        )
    {
        (amountA, amountB, liqAmount) = router.addLiquidity(
            _uniData.tokenA,
            _uniData.tokenB,
            _uniData.amountADesired,
            _uniData.amountBDesired,
            _uniData.amountAMin,
            _uniData.amountBMin,
            _uniData.to,
            _uniData.deadline
        );
    }

    function parseInputs(bytes[] memory _callData)
        internal
        pure
        returns (UniSupplyData memory uniData)
    {
        uniData = abi.decode(_callData[0], (UniSupplyData));
    }
}
