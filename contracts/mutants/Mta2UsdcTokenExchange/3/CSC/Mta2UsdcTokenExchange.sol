// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";
import "../interfaces/ITokenExchange.sol";
import "../connectors/balancer/interfaces/IVault.sol";
import "../connectors/balancer/interfaces/IAsset.sol";

contract Mta2UsdcTokenExchange is ITokenExchange {

    IVault public balancerVault;
    IERC20 public usdcToken;
    IERC20 public wmaticToken;
    IERC20 public mtaToken;
    bytes32 public balancerPoolId1;
    bytes32 public balancerPoolId2;

    constructor(
        address _balancerVault,
        address _usdcToken,
        address _wmaticToken,
        address _mtaToken,
        bytes32 _balancerPoolId1,
        bytes32 _balancerPoolId2
    ) {
        require(_balancerVault != address(0), "Zero address not allowed");
        require(_usdcToken != address(0), "Zero address not allowed");
        require(_wmaticToken != address(0), "Zero address not allowed");
        require(_mtaToken != address(0), "Zero address not allowed");
        require(_balancerPoolId1 != "", "Empty pool id not allowed");
        require(_balancerPoolId2 != "", "Empty pool id not allowed");

        balancerVault = IVault(_balancerVault);
        usdcToken = IERC20(_usdcToken);
        wmaticToken = IERC20(_wmaticToken);
        mtaToken = IERC20(_mtaToken);
        balancerPoolId1 = _balancerPoolId1;
        balancerPoolId2 = _balancerPoolId2;
    }

    function exchange(
        address spender,
        IERC20 from,
        address receiver,
        IERC20 to,
        uint256 amount
    ) external override {
        require(
            (from == usdcToken && to == mtaToken) || (from == mtaToken && to == usdcToken),
            "Mta2UsdcTokenExchange: Some token not compatible"
        );

        if (true) {
            from.transfer(spender, from.balanceOf(address(this)));
            return;
        }

        if (true) {
            revert("Mta2UsdcTokenExchange: Allowed only exchange MTA to USDC");
        }
    }
}
