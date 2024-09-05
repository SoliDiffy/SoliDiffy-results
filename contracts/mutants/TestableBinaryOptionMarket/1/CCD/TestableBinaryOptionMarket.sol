pragma solidity ^0.5.16;

import "../BinaryOptionMarket.sol";

contract TestableBinaryOptionMarket is BinaryOptionMarket {
    

    function updatePrices(
        uint256 longBids,
        uint256 shortBids,
        uint totalDebt
    ) public {
        _updatePrices(longBids, shortBids, totalDebt);
    }

    function setManager(address _manager) public {
        owner = _manager;
    }

    function forceClaim(address account) public {
        options.long.claim(account, prices.long, _exercisableDeposits(deposited));
        options.short.claim(account, prices.short, _exercisableDeposits(deposited));
    }
}
