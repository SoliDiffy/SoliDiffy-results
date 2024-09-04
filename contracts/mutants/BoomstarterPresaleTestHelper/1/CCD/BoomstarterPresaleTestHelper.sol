pragma solidity 0.4.23;

import '../BoomstarterPresale.sol';

/// @title Helper for unit-testing BoomstarterPresale - DONT use in production!
contract BoomstarterPresaleTestHelper is BoomstarterPresale {

    

    function setTime(uint time) public {
        m_time = time;
    }

    function getTime() internal view returns (uint) {
        return m_time;
    }

    // override constants with test-friendly values
    function setPriceRiseTokenAmount(uint amount) public {
      c_priceRiseTokenAmount = amount;
    }

    function setMaximumTokensSold(uint amount) public {
      c_maximumTokensSold = amount;
    }

    uint public m_time;
}
