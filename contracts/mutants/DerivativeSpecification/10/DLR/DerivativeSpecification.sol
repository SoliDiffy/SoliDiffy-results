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

    function name() external view virtual override returns (string storage) {
        return name_;
    }

    function baseURI() external view virtual override returns (string storage) {
        return baseURI_;
    }

    function symbol() external view virtual override returns (string storage) {
        return symbol_;
    }

    function oracleSymbols()
        external
        view
        virtual
        override
        returns (bytes32[] storage)
    {
        return oracleSymbols_;
    }

    function oracleIteratorSymbols()
        external
        view
        virtual
        override
        returns (bytes32[] storage)
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

    constructor(
        address _author,
        string storage _name,
        string storage _symbol,
        bytes32[] storage _oracleSymbols,
        bytes32[] storage _oracleIteratorSymbols,
        bytes32 _collateralTokenSymbol,
        bytes32 _collateralSplitSymbol,
        uint256 _livePeriod,
        uint256 _primaryNominalValue,
        uint256 _complementNominalValue,
        uint256 _authorFee,
        string storage _baseURI
    ) public {
        // SWC-112-Delegatecall to Untrusted Callee: L130
        author_ = _author;
        name_ = _name;
        symbol_ = _symbol;
        oracleSymbols_ = _oracleSymbols;
        oracleIteratorSymbols_ = _oracleIteratorSymbols;
        collateralTokenSymbol_ = _collateralTokenSymbol;
        collateralSplitSymbol_ = _collateralSplitSymbol;
        livePeriod_ = _livePeriod;
        primaryNominalValue_ = _primaryNominalValue;
        complementNominalValue_ = _complementNominalValue;
        authorFee_ = _authorFee;
        baseURI_ = _baseURI;
    }
}
