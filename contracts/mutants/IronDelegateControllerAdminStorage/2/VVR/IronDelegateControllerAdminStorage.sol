pragma solidity ^0.5.16;


contract IronDelegateControllerAdminStorage {
    /**
    * @notice Administrator for this contract
    */
    address internal admin;

    /**
    * @notice Pending administrator for this contract
    */
    address internal pendingAdmin;

    /**
    * @notice Active brains of IronDelegateController
    */
    address public ironControllerImplementation;

    /**
    * @notice Pending brains of IronDelegateController
    */
    address public pendingIronControllerImplementation;
}
