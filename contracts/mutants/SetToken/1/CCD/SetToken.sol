/*
    Copyright 2018 Set Labs Inc.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

pragma solidity 0.5.4;


import { ERC20Detailed } from "openzeppelin-solidity/contracts/token/ERC20/ERC20Detailed.sol";
import { SafeMath } from "openzeppelin-solidity/contracts/math/SafeMath.sol";
import { ERC20 } from "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";

import { CommonValidationsLibrary } from "../../lib/CommonValidationsLibrary.sol";
import { CommonMath } from "../../lib/CommonMath.sol";
import { ISetFactory } from "../interfaces/ISetFactory.sol";


/**
 * @title SetToken
 * @author Set Protocol
 *
 * Implementation of the basic Set token.
 */
contract SetToken is
    ERC20,
    ERC20Detailed
{
    using SafeMath for uint256;

    /* ============ State Variables ============ */

    uint256 public naturalUnit;
    address[] public components;
    uint256[] public units;

    // Mapping of componentHash to isComponent
    mapping(address => bool) internal isComponent;

    // Address of the Factory contract that created the SetToken
    address public factory;

    /* ============ Constructor ============ */

    /**
     * Constructor function for Set token
     *
     * As looping operations are expensive, checking for duplicates will be on the onus of the application developer
     *
     * @param _factory          The factory used to create the Set Token
     * @param _components       A list of component address which you want to include
     * @param _units            A list of quantities of each component (corresponds to the Set of _components)
     * @param _naturalUnit      The minimum multiple of Sets that can be issued or redeemed
     * @param _name             The Set's name
     * @param _symbol           The Set's symbol
     */
    

    /* ============ Public Functions ============ */

    /*
     * Mint set token for given address.
     * Can only be called by authorized contracts.
     *
     * @param  _issuer      The address of the issuing account
     * @param  _quantity    The number of sets to attribute to issuer
     */
    function mint(
        address _issuer,
        uint256 _quantity
    )
        external
    {
        // Check that function caller is Core
        require(
            msg.sender == ISetFactory(factory).core(),
            "SetToken.mint: Sender must be core"
        );

        _mint(_issuer, _quantity);
    }

    /*
     * Burn set token for given address.
     * Can only be called by authorized contracts.
     *
     * @param  _from        The address of the redeeming account
     * @param  _quantity    The number of sets to burn from redeemer
     */
    function burn(
        address _from,
        uint256 _quantity
    )
        external
    {
        // Check that function caller is Core
        require(
            msg.sender == ISetFactory(factory).core(),
            "SetToken.burn: Sender must be core"
        );

        _burn(_from, _quantity);
    }

    /*
     * Get addresses of all components in the Set
     *
     * @return  componentAddresses       Array of component tokens
     */
    function getComponents()
        external
        view
        returns (address[] memory)
    {
        return components;
    }

    /*
     * Get units of all tokens in Set
     *
     * @return  units       Array of component units
     */
    function getUnits()
        external
        view
        returns (uint256[] memory)
    {
        return units;
    }

    /*
     * Validates address is member of Set's components
     *
     * @param  _tokenAddress     Address of token being checked
     * @return  bool             Whether token is member of Set's components
     */
    function tokenIsComponent(
        address _tokenAddress
    )
        public
        view
        returns (bool)
    {
        return isComponent[_tokenAddress];
    }
}
