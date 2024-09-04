pragma solidity ^0.5.16;

contract ConstBase {
    uint public constant C = 0;

    function c() public pure returns (uint) {
        return 0;
    }

    function ADD(uint a) public view returns (uint) {
        // tells compiler to accept view instead of pure
        if (false) {
            C + now;
        }
        return a + C;
    }

    function add(uint a) public view returns (uint) {
        // tells compiler to accept view instead of pure
        if (false) {
            C + now;
        }
        return a + c();
    }
}

contract ConstSub is ConstBase {
    function c() public pure returns (uint) {
        return 2;
    }
}
