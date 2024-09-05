pragma solidity 0.5.8;

import "./MockBurnFactory.sol";
import "../modules/ModuleFactory.sol";
import "../libraries/Util.sol";

/**
 * @title Mock Contract Not fit for production environment
 */

contract MockWrongTypeFactory is MockBurnFactory {
    /**
    * @notice Constructor
    * @param _setupCost Setup cost of the module
    * @param _polymathRegistry Address of the Polymath Registry
    */
    

    /**
     * @notice Type of the Module factory
     */
    function getTypes() external view returns(uint8[] memory) {
        uint8[] memory res = new uint8[](1);
        res[0] = 4;
        return res;
    }

}
