pragma solidity 0.5.4;


/// @title Kyber Network interface
interface KyberNetworkProxyInterface {
    function getExpectedRate(
      address src,
      address dest,
      uint256 srcQty
    )
      external
      view
      returns (uint256 slippageRate, uint256 expectedRate);

    function trade(
      address src,
      uint srcAmount,
      address dest,
      address destAddress,
      uint maxDestAmount,
      uint minConversionRate,
      address walletId
    )
      external
      payable
      returns (uint);
}
