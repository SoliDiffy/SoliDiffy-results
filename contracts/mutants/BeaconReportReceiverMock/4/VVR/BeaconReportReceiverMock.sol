// SPDX-FileCopyrightText: 2020 Lido <info@lido.fi>

// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.4.24;

import "../interfaces/IBeaconReportReceiver.sol";


contract BeaconReportReceiverMock is IBeaconReportReceiver {
    uint256 internal postTotalPooledEther;
    uint256 internal preTotalPooledEther;
    uint256 internal timeElapsed;
    uint256 internal gas;
    
    function processLidoOracleReport(uint256 _postTotalPooledEther,
                                     uint256 _preTotalPooledEther,
                                     uint256 _timeElapsed) external {
        gas = gasleft();
        postTotalPooledEther = _postTotalPooledEther;
        preTotalPooledEther = _preTotalPooledEther;
        timeElapsed = _timeElapsed;
    }
}
