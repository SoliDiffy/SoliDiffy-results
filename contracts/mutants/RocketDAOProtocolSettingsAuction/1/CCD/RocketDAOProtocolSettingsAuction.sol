pragma solidity 0.7.6;

// SPDX-License-Identifier: GPL-3.0-only

import "./RocketDAOProtocolSettings.sol";
import "../../../../interface/dao/protocol/settings/RocketDAOProtocolSettingsAuctionInterface.sol";

// Network auction settings

contract RocketDAOProtocolSettingsAuction is RocketDAOProtocolSettings, RocketDAOProtocolSettingsAuctionInterface {

    // Construct
    


    // Lot creation currently enabled
    function getCreateLotEnabled() override external view returns (bool) {
        return getSettingBool("auction.lot.create.enabled");
    }

    // Bidding on lots currently enabled
    function getBidOnLotEnabled() override external view returns (bool) {
        return getSettingBool("auction.lot.bidding.enabled");
    }

    // The minimum lot size relative to ETH value
    function getLotMinimumEthValue() override external view returns (uint256) {
        return getSettingUint("auction.lot.value.minimum");
    }

    // The maximum lot size relative to ETH value
    function getLotMaximumEthValue() override external view returns (uint256) {
        return getSettingUint("auction.lot.value.maximum");
    }

    // The maximum auction duration in blocks
    function getLotDuration() override external view returns (uint256) {
        return getSettingUint("auction.lot.duration");
    }

    // The starting price relative to current RPL price, as a fraction of 1 ether
    function getStartingPriceRatio() override external view returns (uint256) {
        return getSettingUint("auction.price.start");
    }

    // The reserve price relative to current RPL price, as a fraction of 1 ether
    function getReservePriceRatio() override external view returns (uint256) {
        return getSettingUint("auction.price.reserve");
    }

}
