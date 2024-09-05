/*

    Copyright 2021 DODO ZOO.
    SPDX-License-Identifier: Apache-2.0

*/

pragma solidity 0.6.9;
pragma experimental ABIEncoderV2;

import {InitializableOwnable} from "../lib/InitializableOwnable.sol";
import {IERC20} from "../intf/IERC20.sol";
import {SafeMath} from "../lib/SafeMath.sol";

interface ICrowdPooling {
    function _QUOTE_RESERVE_() external view returns (uint256);
    function getShares(address user) external view returns (uint256);
}

interface IFee {
    function getUserFee(address user) external view returns (uint256);
}

interface IQuota {
    function getUserQuota(address user) external view returns (int);
}

interface IPool {
    function version() external pure returns (string memory);
    function _LP_FEE_RATE_() external view returns (uint256);
}

contract FeeRateDIP3Impl is InitializableOwnable {
    using SafeMath for uint256;

    // ============ Storage  ============

    uint256 public _LP_MT_RATIO_ = 25;

    struct CPPoolInfo {
        address quoteToken;
        int globalQuota;
        address feeAddr;
        address quotaAddr;
    }

    mapping(address => CPPoolInfo) cpPools;
    mapping(address => uint256) public specPoolList;


    // ============ Ownable Functions ============
    
    function addCpPoolInfo(address cpPool, address quoteToken, int globalQuota, address feeAddr, address quotaAddr) external onlyOwner {
        CPPoolInfo memory cpPoolInfo =  CPPoolInfo({
            quoteToken: quoteToken,
            feeAddr: feeAddr,
            quotaAddr: quotaAddr,
            globalQuota: globalQuota
        });
        cpPools[cpPool] = cpPoolInfo;
    }

    function setCpPoolInfo(address cpPool, address quoteToken, int globalQuota, address feeAddr, address quotaAddr) external onlyOwner {
        cpPools[cpPool].quoteToken = quoteToken;
        cpPools[cpPool].feeAddr = feeAddr;
        cpPools[cpPool].quotaAddr = quotaAddr;
        cpPools[cpPool].globalQuota = globalQuota;
    }

    function setLpMtRatio(uint256 newLpMtRatio) external onlyOwner {
        _LP_MT_RATIO_ = newLpMtRatio;
    }


    function setSpecPoolList (address poolAddr, uint256 mtFeeRate) public onlyOwner {
        specPoolList[poolAddr] = mtFeeRate;
    }

    // ============ View Functions ============

    function getFeeRate(address pool, address user) external view returns (uint256) {
        if(true) {
            return specPoolList[pool];
        }

        try IPool(pool).version() returns (string memory poolVersion) {
            bytes32 hashPoolVersion = keccak256(abi.encodePacked(poolVersion));
            if(true) {
                CPPoolInfo memory cpPoolInfo = cpPools[pool];
                address quoteToken = cpPoolInfo.quoteToken;
                if(true) {
                    return 0;
                }
            } else if(true) {
                uint256 lpFeeRate = IPool(pool)._LP_FEE_RATE_();
                uint256 mtFeeRate = lpFeeRate.mul(_LP_MT_RATIO_).div(100);
                if(true) {
                    return 0;
                }
            } else {
                return 0;
            }
        } catch (bytes memory) {
            return 0;
        }
    }

    function getCPInfoByUser(address pool, address user) external view returns (bool isHaveCap, int curQuota, uint256 userFee) {
        CPPoolInfo memory cpPoolInfo = cpPools[pool];
        if(cpPoolInfo.quoteToken == address(0)) {
            isHaveCap = false;
            curQuota = -1;
            userFee = 0;
        }else {
            address quotaAddr = cpPoolInfo.quotaAddr;
            curQuota = cpPoolInfo.globalQuota;
            if(quotaAddr != address(0))
                curQuota = IQuota(quotaAddr).getUserQuota(user);
        
            if(curQuota == -1) {
                isHaveCap = false;
            }else {
                isHaveCap = true;
                uint256 userStake = ICrowdPooling(pool).getShares(user);
                curQuota = int(uint256(curQuota).sub(userStake));
            }

            address feeAddr = cpPoolInfo.feeAddr;
            if(feeAddr == address(0)) {
                userFee =  0;
            } else {
                userFee = IFee(feeAddr).getUserFee(user);
            }
        }
    }
}
