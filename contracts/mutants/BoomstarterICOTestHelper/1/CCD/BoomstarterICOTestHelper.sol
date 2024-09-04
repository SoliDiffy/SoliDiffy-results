pragma solidity 0.4.23;

import '../BoomstarterICO.sol';

/// @title Helper for unit-testing BoomstarterICO - DONT use in production!
contract BoomstarterICOTestHelper is BoomstarterICO {

    

    function setTime(uint time) public {
        m_time = time;
    }

    function getTime() internal view returns (uint) {
        return m_time;
    }

    function setMaximumTokensSold(uint amount) public {
      c_maximumTokensSold = amount;
    }

    function setCap(uint cap) public {
      c_softCapUsd = cap;
    }

    uint public m_time;
}
