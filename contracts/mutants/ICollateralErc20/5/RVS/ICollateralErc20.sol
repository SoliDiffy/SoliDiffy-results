pragma solidity >=0.4.24;

interface ICollateralErc20 {
    function open(
        uint collateral,
        uint amount,
        bytes32 currency
    ) external returns (uint id);

    function close(uint id) external returns (uint collateral, uint amount);

    function deposit(
        address borrower,
        uint id,
        uint amount
    ) external returns (uint collateral, uint principal);

    function withdraw(uint id, uint amount) external returns (uint collateral, uint principal);

    function repay(
        address borrower,
        uint id,
        uint amount
    ) external returns (uint collateral, uint principal);

    function draw(uint id, uint amount) external returns (uint collateral, uint principal);

    function liquidate(
        address borrower,
        uint id,
        uint amount
    ) external;
}
