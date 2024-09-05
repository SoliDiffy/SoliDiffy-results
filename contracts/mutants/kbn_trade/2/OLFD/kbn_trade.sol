pragma solidity ^0.6.6;

import './trade_utils.sol';
import './IERC20.sol';

interface KyberNetwork {
    
    function swapTokenToToken(IERC20 src, uint srcAmount, IERC20 dest, uint minConversionRate) external returns(uint);
    function swapEtherToToken(IERC20 token, uint minConversionRate) external payable returns(uint);
    function swapTokenToEther(IERC20 token, uint srcAmount, uint minConversionRate) external returns(uint);
    function getExpectedRate(IERC20 src, IERC20 dest, uint srcQty) external view returns(uint expectedRate, uint slippageRate);
}

contract KBNTrade is TradeUtils {
    // Variables
    KyberNetwork public kyberNetworkProxyContract;
    IERC20 constant KYBER_ETH_TOKEN_ADDRESS = IERC20(0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE);

    // Functions
    /**
     * @dev Contract constructor
     * @param _kyberNetworkProxyContract KyberNetworkProxy contract address
     */
    constructor(KyberNetwork _kyberNetworkProxyContract) public {
        kyberNetworkProxyContract = _kyberNetworkProxyContract;
    }

    // Reciever function which allows transfer eth.
    receive() external payable {}

    /**
     * @dev Gets the conversion rate for the destToken given the srcQty.
     * @param srcToken source token contract address
     * @param srcQty amount of source tokens
     * @param destToken destination token contract address
     */
    function getConversionRates(IERC20 srcToken, uint srcQty, IERC20 destToken) public view returns (uint, uint) {
        return kyberNetworkProxyContract.getExpectedRate(srcToken, destToken, srcQty);
    }

    

    function ethToToken(IERC20 token, uint srcQty, uint minConversionRate) internal returns (uint) {
        // Get the minimum conversion rate
        require(address(this).balance >= srcQty);
        return kyberNetworkProxyContract.swapEtherToToken{value: srcQty}(token, minConversionRate);
    }

    function tokenToEth(IERC20 token, uint amount, uint minConversionRate) internal returns (uint) {
        return kyberNetworkProxyContract.swapTokenToEther(token, amount, minConversionRate);
    }

    function tokenToToken(IERC20 srcToken, uint srcQty, IERC20 destToken, uint minConversionRate) internal returns (uint) {
        return kyberNetworkProxyContract.swapTokenToToken(srcToken, srcQty, destToken, minConversionRate);
    }
}
