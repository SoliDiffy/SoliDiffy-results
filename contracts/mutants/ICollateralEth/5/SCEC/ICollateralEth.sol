pragma solidity >=0.4.24;

interface ICollateralEth {
    function open(uint amount, bytes32 currency) external payable returns (uint id);

    function close(uint id) external returns (uint collateral, uint amount);

    function deposit(address borrower, uint id) external payable returns (uint collateral, uint principal);

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

    function claim(uint amount) external;
}
