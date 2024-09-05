// SPDX-License-Identifier: GPL-3.0-or-later
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

// This flash loan provider was based on the Aave protocol's open source
// implementation and terminology and interfaces are intentionally kept
// similar

pragma solidity ^0.7.0;
pragma experimental ABIEncoderV2;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/SafeERC20.sol";

import "../lib/helpers/ReentrancyGuard.sol";

import "./Fees.sol";
import "./interfaces/IFlashLoanReceiver.sol";

abstract contract FlashLoanProvider is ReentrancyGuard, Fees {
    using SafeMath for uint256;
    using SafeERC20 for IERC20;

    
}
