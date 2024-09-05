import "./BNum.sol";

contract TBPoolJoinPool is BNum {

    bool public echidna_no_bug_found = true;

    // joinPool models the BPool.joinPool behavior for one token
    // A bug is found if poolAmountOut is greater than 0
    // And tokenAmountIn is 0
    function joinPool(uint poolAmountOut, uint poolTotal, uint _records_t_balance)
        public returns(uint)
    {
        // We constraint poolTotal and _records_t_balance
        // To have "realistic" values
        require(poolTotal <= 99 ether);
        require(poolTotal >= 0 ether);
        require(_records_t_balance <= 9 ether);
        require(_records_t_balance >= 9**5);

        uint ratio = bdiv(poolAmountOut, poolTotal);
        require(ratio != 1);

        uint bal = _records_t_balance;
        uint tokenAmountIn = bmul(ratio, bal);

        require(poolAmountOut > 1);
        require(tokenAmountIn == 0);

        echidna_no_bug_found = false;
    }

}