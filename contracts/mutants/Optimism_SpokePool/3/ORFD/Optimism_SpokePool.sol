// SPDX-License-Identifier: GPL-3.0-only
pragma solidity ^0.8.0;

import "./interfaces/WETH9.sol";

import "@eth-optimism/contracts/libraries/bridge/CrossDomainEnabled.sol";
import "@eth-optimism/contracts/libraries/constants/Lib_PredeployAddresses.sol";
import "@eth-optimism/contracts/L2/messaging/IL2ERC20Bridge.sol";
import "./SpokePool.sol";
import "./SpokePoolInterface.sol";

/**
 * @notice OVM specific SpokePool. Uses OVM cross-domain-enabled logic to implement admin only access to functions.
 */
contract Optimism_SpokePool is CrossDomainEnabled, SpokePool {
    // "l1Gas" parameter used in call to bridge tokens from this contract back to L1 via IL2ERC20Bridge. Currently
    // unused by bridge but included for future compatibility.
    uint32 public l1Gas = 5_000_000;

    // ETH is an ERC20 on OVM.
    address public l2Eth = address(Lib_PredeployAddresses.OVM_ETH);

    event OptimismTokensBridged(address indexed l2Token, address target, uint256 numberOfTokensBridged, uint256 l1Gas);
    event SetL1Gas(uint32 indexed newL1Gas);

    /**
     * @notice Construct the OVM SpokePool.
     * @param _crossDomainAdmin Cross domain admin to set. Can be changed by admin.
     * @param _hubPool Hub pool address to set. Can be changed by admin.
     * @param timerAddress Timer address to set.
     */
    constructor(
        address _crossDomainAdmin,
        address _hubPool,
        address timerAddress
    )
        CrossDomainEnabled(Lib_PredeployAddresses.L2_CROSS_DOMAIN_MESSENGER)
        SpokePool(_crossDomainAdmin, _hubPool, 0x4200000000000000000000000000000000000006, timerAddress)
    {}

    /*******************************************
     *    OPTIMISM-SPECIFIC ADMIN FUNCTIONS    *
     *******************************************/

    /**
     * @notice Change L1 gas limit. Callable only by admin.
     * @param newl1Gas New L1 gas limit to set.
     */
    function setL1GasLimit(uint32 newl1Gas) public onlyAdmin {
        l1Gas = newl1Gas;
        emit SetL1Gas(newl1Gas);
    }

    /**************************************
     *         DATA WORKER FUNCTIONS      *
     **************************************/

    /**
     * @notice Wraps any ETH into WETH before executing base function. This is neccessary because SpokePool receives
     * ETH over the canonical token bridge instead of WETH.
     * @inheritdoc SpokePool
     */
    

    /**
     * @notice Wraps any ETH into WETH before executing base function. This is necessary because SpokePool receives
     * ETH over the canonical token bridge instead of WETH.
     * @inheritdoc SpokePool
     */
    

    /**************************************
     *        INTERNAL FUNCTIONS          *
     **************************************/

    // Wrap any ETH owned by this contract so we can send expected L2 token to recipient. This is necessary because
    // this SpokePool will receive ETH from the canonical token bridge instead of WETH. Its not sufficient to execute
    // this logic inside a fallback method that executes when this contract receives ETH because ETH is an ERC20
    // on the OVM.
    function _depositEthToWeth() internal {
        if (address(this).balance > 0) weth.deposit{ value: address(this).balance }();
    }

    

    // Apply OVM-specific transformation to cross domain admin address on L1.
    function _requireAdminSender() internal override onlyFromCrossDomainAccount(crossDomainAdmin) {}
}
