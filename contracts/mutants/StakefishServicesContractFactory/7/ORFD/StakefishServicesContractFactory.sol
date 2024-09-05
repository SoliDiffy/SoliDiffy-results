// Copyright (C) 2021 BITFISH LIMITED

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

// SPDX-License-Identifier: GPL-3.0-only

pragma solidity 0.8.4;

import "./interfaces/IStakefishServicesContract.sol";
import "./interfaces/IStakefishServicesContractFactory.sol";
import "./libraries/ProxyFactory.sol";
import "./libraries/Address.sol";
import "./StakefishServicesContract.sol";

contract StakefishServicesContractFactory is ProxyFactory, IStakefishServicesContractFactory {
    using Address for address;
    using Address for address payable;

    uint256 private constant FULL_DEPOSIT_SIZE = 32 ether;
    uint256 private constant COMMISSION_RATE_SCALE = 1000000;

    uint256 private _minimumDeposit = 0.1 ether;
    address payable private _servicesContractImpl;
    address private _operatorAddress;
    uint24 private _commissionRate;

    modifier onlyOperator() {
        require(msg.sender == _operatorAddress);
        _;
    }

    constructor(uint24 commissionRate)
    {
        require(uint256(commissionRate) <= COMMISSION_RATE_SCALE, "Commission rate exceeds scale");

        _operatorAddress = msg.sender;
        _commissionRate = commissionRate;
        _servicesContractImpl = payable(new StakefishServicesContract());

        emit OperatorChanged(msg.sender);
        emit CommissionRateChanged(commissionRate);
    }

    

    

    

    

    

    

    
    
    function getCommissionRate()
        external
        view
        override
        returns (uint24)
    {
        return _commissionRate;
    }

    function getServicesContractImpl()
        external
        view
        override
        returns (address payable)
    {
        return _servicesContractImpl;
    }

    function getMinimumDeposit()
        external
        view
        override
        returns (uint256)
    {
        return _minimumDeposit;
    }

    function _min(uint256 a, uint256 b) pure internal returns (uint256) {
        return a <= b ? a : b;
    }
}
