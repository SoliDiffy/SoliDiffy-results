// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;
pragma experimental ABIEncoderV2;

import "../../interfaces/uniswap/IUniswapV2Factory.sol";
import "../../interfaces/exchange/IUniswapRouter.sol";
import "../../utils/TokenUtils.sol";
import "../ActionBase.sol";

/// @title Supplies liquidity to uniswap
contract UniWithdraw is ActionBase {
    using TokenUtils for address;

    IUniswapRouter public constant router =
        IUniswapRouter(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);

    IUniswapV2Factory public constant factory =
        IUniswapV2Factory(0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f);

    struct UniWithdrawData {
        address tokenA;
        address tokenB;
        uint256 liquidity;
        address to;
        address from;
        uint256 amountAMin;
        uint256 amountBMin;
        uint256 deadline;
    }

    /// @inheritdoc ActionBase
    

    /// @inheritdoc ActionBase
    

    /// @inheritdoc ActionBase
    function actionType() public pure virtual override returns (uint8) {
        return uint8(ActionType.STANDARD_ACTION);
    }

    //////////////////////////// ACTION LOGIC ////////////////////////////

    /// @notice Removes liquidity from uniswap
    /// @param _uniData All the required data to withdraw from uni
    function _uniWithdraw(UniWithdrawData memory _uniData) internal returns (uint256) {
        address lpTokenAddr = factory.getPair(_uniData.tokenA, _uniData.tokenB);

        lpTokenAddr.pullTokens(_uniData.from, _uniData.liquidity);
        lpTokenAddr.approveToken(address(router), _uniData.liquidity);

        // withdraw liq. and get info how much we got out
        (uint256 amountA, uint256 amountB) = _withdrawLiquidity(_uniData);

        logger.Log(
            address(this),
            msg.sender,
            "UniWithdraw",
            abi.encode(_uniData, amountA, amountB)
        );

        return _uniData.liquidity;
    }

    function _withdrawLiquidity(UniWithdrawData memory _uniData)
        internal
        returns (uint256 amountA, uint256 amountB)
    {
        (amountA, amountB) = router.removeLiquidity(
            _uniData.tokenA,
            _uniData.tokenB,
            _uniData.liquidity,
            _uniData.amountAMin,
            _uniData.amountBMin,
            _uniData.to,
            _uniData.deadline
        );
    }

    function parseInputs(bytes[] memory _callData)
        internal
        pure
        returns (UniWithdrawData memory uniData)
    {
        uniData = abi.decode(_callData[0], (UniWithdrawData));
    }
}
