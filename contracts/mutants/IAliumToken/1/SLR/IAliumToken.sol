pragma solidity 0.6.12;

import "";

interface IAliumToken is IBEP20 {
    function mint(address _to, uint256 _amount) external;
    function burn(uint256 _amount) external;
}