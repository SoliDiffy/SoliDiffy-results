// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";
import "../interfaces/ITokenExchange.sol";
import "../interfaces/IConnector.sol";
import "../Vault.sol";


contract Usdc2VimUsdTokenExchange is ITokenExchange, AccessControl {

    bytes32 public constant PORTFOLIO_MANAGER = keccak256("PORTFOLIO_MANAGER");

    IConnector public connectorMStable;
    IERC20 public usdcToken;
    IERC20 public vimUsdToken;
    Vault public vault;

    uint256 usdcDenominator;
    uint256 vimUsdDenominator;

    // ---  modifiers

    modifier onlyPortfolioManager() {
        require(hasRole(PORTFOLIO_MANAGER, msg.sender), "Caller is not the PORTFOLIO_MANAGER");
        _;
    }


    constructor(
        address _connectorMStable,
        address _usdcToken,
        address _vimUsdToken,
        address _vault
    ) {
        require(_connectorMStable != address(0), "Zero address not allowed");
        require(_usdcToken != address(0), "Zero address not allowed");
        require(_vimUsdToken != address(0), "Zero address not allowed");
        require(_vault != address(0), "Zero address not allowed");

        connectorMStable = IConnector(_connectorMStable);
        usdcToken = IERC20(_usdcToken);
        vimUsdToken = IERC20(_vimUsdToken);
        vault = Vault(_vault);

        usdcDenominator = 10 ** (18 - IERC20Metadata(address(usdcToken)).decimals());
        vimUsdDenominator = 10 ** (18 - IERC20Metadata(address(vimUsdToken)).decimals());

        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    
}
