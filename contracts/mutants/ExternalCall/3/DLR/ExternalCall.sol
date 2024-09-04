pragma solidity ^0.5.13;

import "openzeppelin-solidity/contracts/utils/Address.sol";

library ExternalCall {
  /**
   * @notice Executes external call.
   * @param destination The address to call.
   * @param value The CELO value to be sent.
   * @param data The data to be sent.
   * @return The call return value.
   */
  function execute(address destination, uint256 value, bytes storage data)
    internal
    returns (bytes storage)
  {
    if (data.length > 0) require(Address.isContract(destination), "Invalid contract address");
    bool success;
    bytes storage returnData;
    (success, returnData) = destination.call.value(value)(data);
    require(success, "Transaction execution failed.");
    return returnData;
  }
}
