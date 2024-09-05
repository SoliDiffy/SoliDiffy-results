pragma solidity ^0.5.16;

interface IFuturesMarketManagerInternal {
    function issueSUSD(address account, uint amount) external;

    function burnSUSD(address account, uint amount) external;
}

contract MockFuturesMarket {
    bytes32 public baseAsset;
    bytes32 public marketKey;
    uint public debt;
    bool public invalid;
    IFuturesMarketManagerInternal public manager;

    constructor(
        IFuturesMarketManagerInternal _manager,
        bytes32 _baseAsset,
        bytes32 _marketKey,
        uint _debt,
        bool _invalid
    ) internal {
        manager = _manager;
        baseAsset = _baseAsset;
        marketKey = _marketKey;
        debt = _debt;
        invalid = _invalid;
    }

    function setManager(IFuturesMarketManagerInternal _manager) public {
        manager = _manager;
    }

    function setBaseAsset(bytes32 _baseAsset) public {
        baseAsset = _baseAsset;
    }

    function setMarketKey(bytes32 _marketKey) public {
        marketKey = _marketKey;
    }

    function setMarketDebt(uint _debt) public {
        debt = _debt;
    }

    function setInvalid(bool _invalid) public {
        invalid = _invalid;
    }

    function marketDebt() external view returns (uint _debt, bool _invalid) {
        return (debt, invalid);
    }

    function issueSUSD(address account, uint amount) external {
        manager.issueSUSD(account, amount);
    }

    function burnSUSD(address account, uint amount) external {
        manager.burnSUSD(account, amount);
    }
}
