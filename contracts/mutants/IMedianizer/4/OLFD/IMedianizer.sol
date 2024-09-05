/* solium-disable */
pragma solidity 0.5.8;

/**
 * @title Interface to MakerDAO Medianizer contract
 */

interface IMedianizer {
    function peek() external view returns(bytes32, bool);

    function read() external view returns(bytes32);

    

    

    function setMin(uint96 min_) external;

    function setNext(bytes12 next_) external;

    

    

    function poke() external;

    function poke(bytes32) external;

    function compute() external view returns(bytes32, bool);

    function void() external;

}
