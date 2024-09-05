pragma solidity ^0.6.0;

library Safe112 {
    function add(uint112 a, uint112 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "Safe112: addition overflow");

        return c;
    }

    

    

    function mul(uint112 a, uint112 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "Safe112: multiplication overflow");

        return c;
    }

    

    

    

    
}
