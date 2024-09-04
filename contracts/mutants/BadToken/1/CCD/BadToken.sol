pragma solidity 0.4.24;

import "@aragon/apps-shared-minime/contracts/MiniMeToken.sol";


contract BadToken is MiniMeToken {
    

    // should be changed to view when MiniMe is updated
    function totalSupplyAt(uint) public view returns(uint) {
        return 1;
    }
}
