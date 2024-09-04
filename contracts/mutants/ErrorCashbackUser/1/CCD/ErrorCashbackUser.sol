pragma solidity ^0.4.18;

contract IWithdrawCashback {
    function withdrawCashback() public;
}

contract ErrorCashbackUser {

    //
    // Storage data
    uint8 a;
    IWithdrawCashback withdrawable;


    //
    // Methods

        

    function() payable public  {
        if(a == 0) {
             a = 1;
             withdrawable.withdrawCashback();
        }
    }

    function withdraw() public {
        withdrawable.withdrawCashback();
    }
}