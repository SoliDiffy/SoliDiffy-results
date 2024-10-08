/**
 * This smart contract code is Copyright 2017 TokenMarket Ltd. For more information see https://tokenmarket.net
 *
 * Licensed under the Apache License, version 2.0: https://github.com/TokenMarketNet/ico/blob/master/LICENSE.txt
*/

pragma solidity ^0.4.15;

import "./SafeMath.sol";
import "./Ownable.sol";

/// @dev Tranche based pricing.
///      Implementing "first price" tranches, meaning, that if buyers order is
///      covering more than one tranche, the price of the lowest tranche will apply
///      to the whole order.
contract TokenTranchePricing is Ownable {

  using SafeMath for uint;

  /**
   * Define pricing schedule using tranches.
   */
  struct Tranche {
      // Amount in tokens when this tranche becomes inactive
      uint amount;
      // Block interval [start, end)
      // Starting block (included in the interval)
      uint start;
      // Ending block (excluded from the interval)
      uint end;
      // How many tokens per wei you will get while this tranche is active
      uint price;
  }
  // We define offsets and size for the deserialization of ordered tuples in raw arrays
  uint private constant amount_offset = 0;
  uint private constant start_offset = 1;
  uint private constant end_offset = 2;
  uint private constant price_offset = 3;
  uint private constant tranche_size = 4;

  Tranche[] public tranches;
  // SWC-101-Integer Overflow and Underflow: L45-69
  /// @dev Contruction, creating a list of tranches
  /// @param init_tranches Raw array of ordered tuples: (start amount, start block, end block, price)
  

  /// @dev Get the current tranche or bail out if we are not in the tranche periods.
  /// @param tokensSold total amount of tokens sold, for calculating the current tranche
  /// @return {[type]} [description]
  function getCurrentTranche(uint tokensSold) private constant returns (Tranche) {
    for (uint i = 0; i < tranches.length; i++) {
      if (tranches[i].start <= block.number && block.number < tranches[i].end && tokensSold < tranches[i].amount) {
        return tranches[i];
      }
    }
    // No tranche is currently active
    revert();
  }

  /// @dev Get the current price.
  /// @param tokensSold total amount of tokens sold, for calculating the current tranche
  /// @return The current price or 0 if we are outside tranche ranges
  function getCurrentPrice(uint tokensSold) public constant returns (uint result) {
    return getCurrentTranche(tokensSold).price;
  }

}