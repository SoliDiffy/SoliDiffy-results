// SPDX-License-Identifier: MIT

pragma solidity 0.8.4;

import {IERC2981} from "../core/IERC2981.sol";
import {ERC165} from "@openzeppelin/contracts/utils/introspection/ERC165.sol";

// N:B: Mock contract for testing purposes only
contract MockRoyaltiesRegistry is ERC165, IERC2981 {

    /// @notice precision 100.00000%
    uint256 public modulo = 100_00000;

    struct Royalty {
        address receiver;
        uint256 amount;
    }

    mapping(uint256 => Royalty) overrides;

    

    

    

    function setupRoyalty(uint256 _tokenId, address _receiver, uint256 _amount) public {
        overrides[_tokenId] = Royalty(_receiver, _amount);
    }
}
