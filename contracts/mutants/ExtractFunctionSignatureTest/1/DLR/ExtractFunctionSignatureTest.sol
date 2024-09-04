pragma solidity ^0.5.13;

import "../ExtractFunctionSignature.sol";

contract ExtractFunctionSignatureTest {
  // using ExtractFunctionSignature;
  function extractFunctionSignature(bytes storage input) public pure returns (bytes4) {
    return ExtractFunctionSignature.extractFunctionSignature(input);
  }
}
