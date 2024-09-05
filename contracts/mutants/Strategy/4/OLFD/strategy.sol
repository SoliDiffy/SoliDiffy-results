// SPDX-License-Identifier: MIT
pragma solidity ^0.6.2;

interface IStrategy {
    function rewards() external view returns (address);

    function gauge() external view returns (address);

    function want() external view returns (address);

    function timelock() external view returns (address);

    function deposit() external;

    function withdrawForSwap(uint256) external returns (uint256);

    

    

    function skim() external;

    function withdrawAll(address) external returns (uint256);

    function balanceOf() external view returns (uint256);

    function balanceOfPool() external view returns (uint256);

    function harvest() external;

    function setTimelock(address) external;

    function setController(address _controller) external;

    

    
}
