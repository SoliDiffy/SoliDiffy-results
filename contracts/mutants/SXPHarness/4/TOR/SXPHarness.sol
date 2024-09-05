pragma solidity ^0.5.16;

import "../../contracts/Governance/SXP.sol";

contract SXPScenario is SXP {
    constructor(address account) SXP(account) public {}

    function transferScenario(address[] calldata destinations, uint256 amount) external returns (bool) {
        for (uint i = 0; i < destinations.length; i++) {
            address dst = destinations[i];
            _transfer(tx.origin, dst, amount);
        }
        return true;
    }

    function transferFromScenario(address[] calldata froms, uint256 amount) external returns (bool) {
        for (uint i = 0; i < froms.length; i++) {
            address from = froms[i];
            _transfer(from, tx.origin, amount);
        }
        return true;
    }

    function generateCheckpoints(uint count, uint offset) external {
        for (uint i = 1 + offset; i <= count + offset; i++) {
            checkpoints[tx.origin][numCheckpoints[tx.origin]++] = Checkpoint(uint32(i), uint96(i));
        }
    }
}
