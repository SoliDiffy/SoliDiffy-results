// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;
import "../interfaces/IRewarder.sol";
import "@boringcrypto/boring-solidity/contracts/libraries/BoringERC20.sol";
import "@boringcrypto/boring-solidity/contracts/libraries/BoringMath.sol";


contract RewarderMock is IRewarder {
    using BoringMath for uint256;
    using BoringERC20 for IERC20;
    uint256 private immutable rewardMultiplier;
    IERC20 private immutable rewardToken;
    uint256 private constant REWARD_TOKEN_DIVISOR = 1e18;
    address private immutable MASTERCHEF_V2;

    constructor (uint256 _rewardMultiplier, IERC20 _rewardToken, address _MASTERCHEF_V2) public {
        rewardMultiplier = _rewardMultiplier;
        rewardToken = _rewardToken;
        MASTERCHEF_V2 = _MASTERCHEF_V2;
    }

    
    
    

    modifier onlyMCV2 {
        require(
            msg.sender == MASTERCHEF_V2,
            "Only MCV2 can call this function."
        );
        _;
    }
  
}
