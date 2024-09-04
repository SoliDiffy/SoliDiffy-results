pragma solidity ^0.4.10;

/**@dev Throws an exception when there is ether transfer to this account */
contract ErrorVendor {

    function ()  {
        
    }
}

/**@dev A contract with payable function that consumes large amount of gas */
contract HugePayableFunction {
    function HugePayableFunction() {}
    
    uint v1;

    function() payable {
        v1 = 0;
        uint a = 1;
        for (uint i = 1; i < 1000; ++i) {
            a += i;
        }
    }
}

contract Buyable {
    function buy(string clientId) payable;
}

/**@dev A contract that tries to call a calling method again */
contract ReenterAttackVendor {
    function ReenterAttackVendor() {}

    function () payable {
        Buyable s = Buyable(msg.sender);
        s.buy.value(0)("ERROR!");
    }
}

