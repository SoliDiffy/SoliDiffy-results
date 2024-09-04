// "SPDX-License-Identifier: GPL-3.0-or-later"

pragma solidity 0.7.6;

import "@chainlink/contracts/src/v0.6/interfaces/AggregatorInterface.sol";
import "./IDerivativeSpecification.sol";

contract DerivativeSpecification is IDerivativeSpecification {
    function isDerivativeSpecification() external pure override returns (bool) {
        return true;
    }

    string internal symbol_;

    bytes32[] internal oracleSymbols_;
    bytes32[] internal oracleIteratorSymbols_;
    bytes32 internal collateralTokenSymbol_;
    bytes32 internal collateralSplitSymbol_;

    uint256 internal livePeriod_;

    uint256 internal primaryNominalValue_;
    uint256 internal complementNominalValue_;

    uint256 internal authorFee_;

    string internal name_;
    string private baseURI_;
    address internal author_;

    function name() external view virtual override returns (string memory) {
        return name_;
    }

    function baseURI() external view virtual override returns (string memory) {
        return baseURI_;
    }

    function symbol() external view virtual override returns (string memory) {
        return symbol_;
    }

    function oracleSymbols()
        external
        view
        virtual
        override
        returns (bytes32[] memory)
    {
        return oracleSymbols_;
    }

    function oracleIteratorSymbols()
        external
        view
        virtual
        override
        returns (bytes32[] memory)
    {
        return oracleIteratorSymbols_;
    }

    function collateralTokenSymbol()
        external
        view
        virtual
        override
        returns (bytes32)
    {
        return collateralTokenSymbol_;
    }

    function collateralSplitSymbol()
        external
        view
        virtual
        override
        returns (bytes32)
    {
        return collateralSplitSymbol_;
    }

    function livePeriod() external view virtual override returns (uint256) {
        return livePeriod_;
    }

    function primaryNominalValue()
        external
        view
        virtual
        override
        returns (uint256)
    {
        return primaryNominalValue_;
    }

    function complementNominalValue()
        external
        view
        virtual
        override
        returns (uint256)
    {
        return complementNominalValue_;
    }

    function authorFee() external view virtual override returns (uint256) {
        return authorFee_;
    }

    function author() external view virtual override returns (address) {
        return author_;
    }

    
}
