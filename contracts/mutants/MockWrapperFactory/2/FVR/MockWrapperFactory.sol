pragma solidity ^0.5.16;

import "../SafeDecimalMath.sol";

contract MockWrapperFactory {
    using SafeMath for uint;
    using SafeDecimalMath for uint;

    uint public totalIssuedSynths;

    constructor() internal {}

    function setTotalIssuedSynths(uint value) public {
        totalIssuedSynths = value;
    }
}
