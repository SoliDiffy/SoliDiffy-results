// SPDX-License-Identifier: GPL
pragma solidity ^0.6.6;

import "./interfaces/IOneSwapRouter.sol";
import "./interfaces/IOneSwapFactory.sol";
import "./interfaces/IOneSwapPair.sol";
import "./interfaces/IWETH.sol";
import "./interfaces/IERC20.sol";
import "./libraries/SafeMath256.sol";
import "./libraries/DecFloat32.sol";


contract OneSwapRouter is IOneSwapRouter {
    using SafeMath256 for uint;
    address public immutable override factory;
    address public immutable override weth;

    modifier ensure(uint deadline) {
        // solhint-disable-next-line not-rely-on-time,
        require(deadline >= block.timestamp, "OneSwapRouter: EXPIRED");
        _;
    }

    constructor(address _factory, address _weth) public {
        factory = _factory;
        weth = _weth;
    }

    receive() external payable {
        assert(msg.sender == weth); // only accept ETH via fallback from the WETH contract
    }

    function _addLiquidity(address pair, uint amountStockDesired, uint amountMoneyDesired,
        uint amountStockMin, uint amountMoneyMin) private view returns (uint amountStock, uint amountMoney) {

        (uint reserveStock, uint reserveMoney, ) = IOneSwapPool(pair).getReserves();
        if (reserveStock == 0 && reserveMoney == 0) {
            (amountStock, amountMoney) = (amountStockDesired, amountMoneyDesired);
        } else {
            uint amountMoneyOptimal = _quote(amountStockDesired, reserveStock, reserveMoney);
            if (amountMoneyOptimal <= amountMoneyDesired) {
                require(amountMoneyOptimal >= amountMoneyMin, "OneSwapRouter: INSUFFICIENT_MONEY_AMOUNT");
                (amountStock, amountMoney) = (amountStockDesired, amountMoneyOptimal);
            } else {
                uint amountStockOptimal = _quote(amountMoneyDesired, reserveMoney, reserveStock);
                assert(amountStockOptimal <= amountStockDesired);
                require(amountStockOptimal >= amountStockMin, "OneSwapRouter: INSUFFICIENT_STOCK_AMOUNT");
                (amountStock, amountMoney) = (amountStockOptimal, amountMoneyDesired);
            }
        }
    }

    

    

    function _removeLiquidity(address pair, uint liquidity, uint amountStockMin,
        uint amountMoneyMin, address to) private returns (uint amountStock, uint amountMoney) {
        IERC20(pair).transferFrom(msg.sender, pair, liquidity);
        (amountStock, amountMoney) = IOneSwapPool(pair).burn(to);
        require(amountStock >= amountStockMin, "OneSwapRouter: INSUFFICIENT_STOCK_AMOUNT");
        require(amountMoney >= amountMoneyMin, "OneSwapRouter: INSUFFICIENT_MONEY_AMOUNT");
    }

    

    

    function _swap(address input, uint amountIn, address[] memory path, address _to) internal virtual returns (uint[] memory amounts) {
        amounts = new uint[](path.length + 1);
        amounts[0] = amountIn;

        for (uint i = 0; i < path.length; i++) {
            (address to, bool isLastSwap) = i < path.length - 1 ? (path[i+1], false) : (_to, true);
            amounts[i + 1] = IOneSwapPair(path[i]).addMarketOrder(input, to, uint112(amounts[i]), isLastSwap);
            if (!isLastSwap) {
                (address stock, address money)= _getTokensFromPair(path[i]);
                input = (stock != input) ? stock : money;
            }
        }
    }

    

    

    

    // todo. add encoded bytes interface for limitOrder.

    

    

    function _safeTransfer(address token, address to, uint value) internal {
        // bytes4(keccak256(bytes('transfer(address,uint256)')));
        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory data) = token.call(abi.encodeWithSelector(0xa9059cbb, to, value));
        require(success && (data.length == 0 || abi.decode(data, (bool))), "TransferHelper: TRANSFER_FAILED");
    }

    function _safeTransferFrom(address token, address from, address to, uint value) internal {
        // bytes4(keccak256(bytes('transferFrom(address,address,uint256)')));
        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory data) = token.call(abi.encodeWithSelector(0x23b872dd, from, to, value));
        require(success && (data.length == 0 || abi.decode(data, (bool))), "TransferHelper: TRANSFER_FROM_FAILED");
    }

    function _safeTransferETH(address to, uint value) internal {
        // solhint-disable-next-line avoid-low-level-calls
        (bool success,) = to.call{value:value}(new bytes(0));
        require(success, "TransferHelper: ETH_TRANSFER_FAILED");
    }

    function _quote(uint amountA, uint reserveA, uint reserveB) internal pure returns (uint amountB) {
        require(amountA > 0, "OneSwapRouter: INSUFFICIENT_AMOUNT");
        require(reserveA > 0 && reserveB > 0, "OneSwapRouter: INSUFFICIENT_LIQUIDITY");
        amountB = amountA.mul(reserveB) / reserveA;
    }

    function _getTokensFromPair(address pair)internal view returns(address stock, address money) {
        (stock, money) = IOneSwapFactory(factory).getTokensFromPair(pair);
        require(stock != address(0) && money != address(0), "OneSwapRouter: PAIR_MISMATCH");
    }
}
