pragma solidity 0.4.23;

import '../BoomstarterPreICO.sol';

/// @title Helper for unit-testing BoomstarterPreICO - DONT use in production!
contract BoomstarterPreICOTestHelper is BoomstarterPreICO {

    

    function setTime(uint time) public {
        m_time = time;
    }

    function getTime() internal view returns (uint) {
        return m_time;
    }

    function setMaximumTokensSold(uint amount) public {
      c_maximumTokensSold = amount;
    }

    uint public m_time;
}
