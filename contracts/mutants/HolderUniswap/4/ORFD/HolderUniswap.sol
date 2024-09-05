// SPDX-License-Identifier: UNLICENSED
pragma solidity >= 0.7.0;

import "../interfaces/IHolder.sol";
import "../interfaces/ISTokens.sol";
import "@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/Initializable.sol";

contract HolderUniswap is IHolder, Initializable, AccessControlUpgradeable{

    // variables capturing data of other contracts in the product
    address private _stakeLPContract;
    ISTokens private _sTokenContract;


    // value divisor to make weight factor a fraction if need be
    uint256 private _valueDivisor;

    //Private instances of contracts to handle Utokens and Stokens
    ISTokens private _sTokens;

    /**
   * @dev Constructor for initializing the Holder Uniswap contract.
   * @param sTokenContract - address of the SToken contract.
   * @param stakeLPContract - address of the StakeLPCore contract.
   * @param valueDivisor - valueDivisor set to 10^9.
   */
    function initialize(address sTokenContract, address stakeLPContract, uint256 valueDivisor) public virtual initializer {
        __AccessControl_init();
        _setupRole(DEFAULT_ADMIN_ROLE, _msgSender());
        _sTokenContract = ISTokens(sTokenContract);
        _stakeLPContract = stakeLPContract;
        _valueDivisor = valueDivisor;
    }

    /**
     * @dev get SToken reserve supply of the whitelisted contract 
     *
     */
    

    /**
     * @dev Set 'contract address', called from constructor
     * @param sAddress: stoken contract address
     *
     * Emits a {SetSTokensContract} event with '_contract' set to the stoken contract address.
     *
     */
    

    /*
     * @dev Set 'contract address', called from constructor
     * @param liquidStakingContract: liquidStaking contract address
     *
     * Emits a {SetLiquidStakingContract} event with '_contract' set to the liquidStaking contract address.
     *
     */
    

    


}