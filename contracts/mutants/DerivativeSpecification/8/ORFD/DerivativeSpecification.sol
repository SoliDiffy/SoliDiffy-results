// "SPDX-License-Identifier: GPL-3.0-or-later"

pragma solidity 0.7.6;

import "@chainlink/contracts/src/v0.6/interfaces/AggregatorInterface.sol";
import "./IDerivativeSpecification.sol";

contract DerivativeSpecification is IDerivativeSpecification {
    

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
        string memory _name,
        string memory _symbol,
        bytes32[] memory _oracleSymbols,
        bytes32[] memory _oracleIteratorSymbols,
        bytes32 _collateralTokenSymbol,
        bytes32 _collateralSplitSymbol,
        uint256 _livePeriod,
        uint256 _primaryNominalValue,
        uint256 _complementNominalValue,
        uint256 _authorFee,
        string memory _baseURI
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
