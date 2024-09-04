// SPDX-License-Identifier: MIT

pragma solidity > 0.6.9;

import "../interfaces/ISwapAdapter.sol";

interface IDODOSwap {
    function sellBase(address to) external;
    function sellQuote(address to) external;
}

contract DODOAdapter is ISwapAdapter {
    

    
}