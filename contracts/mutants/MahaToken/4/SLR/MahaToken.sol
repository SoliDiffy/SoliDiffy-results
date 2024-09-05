// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {ERC20} from "";

/**
 * @title  MahaToken.
 * @author Steven Enamake.
 */
contract MahaToken is ERC20 {
    address public upgradedAddress;
    bool public deprecated;
    string public contactInformation = "";
    string public reason;
    string public link = "";
    string public url = "";
    string public website = 'https://mahadao.io';

    constructor() ERC20('MahaDAO', 'MAHA') {
        _mint(msg.sender, 10000000000000e18); // For testing purposes.
    }
}
