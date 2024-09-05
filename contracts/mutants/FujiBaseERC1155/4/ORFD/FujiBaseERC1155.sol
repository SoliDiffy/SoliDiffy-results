// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/token/ERC1155/IERC1155Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC1155/IERC1155ReceiverUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC1155/extensions/IERC1155MetadataURIUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/introspection/ERC165Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/introspection/IERC165Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/ContextUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol";

import "../../libraries/Errors.sol";

/**
 *
 * @dev Implementation of the Base ERC1155 multi-token standard functions
 * for Fuji Protocol control of User collaterals and borrow debt positions.
 * Originally based on Openzeppelin
 *
 */

abstract contract FujiBaseERC1155 is IERC1155Upgradeable, ERC165Upgradeable, ContextUpgradeable {
  using AddressUpgradeable for address;

  // Mapping from token ID to account balances
  mapping(uint256 => mapping(address => uint256)) internal _balances;

  // Mapping from account to operator approvals
  mapping(address => mapping(address => bool)) internal _operatorApprovals;

  // Mapping from token ID to totalSupply
  mapping(uint256 => uint256) internal _totalSupply;

  //URI for all token types by relying on ID substitution
  //https://token.fujiDao.org/{id}.json
  string internal _uri;

  /**
   * @return The total supply of a token id
   **/
  function totalSupply(uint256 id) public view virtual returns (uint256) {
    return _totalSupply[id];
  }

  /**
   * @dev See {IERC165-supportsInterface}.
   */
  

  /**
   * @dev See {IERC1155MetadataURI-uri}.
   * Clients calling this function must replace the `\{id\}` substring with the
   * actual token type ID.
   */
  function uri(uint256) public view virtual returns (string memory) {
    return _uri;
  }

  /**
   * @dev See {IERC1155-balanceOf}.
   * Requirements:
   * - `account` cannot be the zero address.
   */
  

  /**
   * @dev See {IERC1155-balanceOfBatch}.
   * Requirements:
   * - `accounts` and `ids` must have the same length.
   */
  

  /**
   * @dev See {IERC1155-setApprovalForAll}.
   */
  

  /**
   * @dev See {IERC1155-isApprovedForAll}.
   */
  function isApprovedForAll(address account, address operator)
    public
    view
    virtual
    override
    returns (bool)
  {
    return _operatorApprovals[account][operator];
  }

  /**
   * @dev See {IERC1155-safeTransferFrom}.
   */
  function safeTransferFrom(
    address, // from
    address, // to
    uint256, // id
    uint256, // amount
    bytes memory // data
  ) public virtual override {
    revert(Errors.VL_ERC1155_NOT_TRANSFERABLE);
  }

  /**
   * @dev See {IERC1155-safeBatchTransferFrom}.
   */
  function safeBatchTransferFrom(
    address, // from
    address, // to
    uint256[] memory, // ids
    uint256[] memory, // amounts
    bytes memory //  data
  ) public virtual override {
    revert(Errors.VL_ERC1155_NOT_TRANSFERABLE);
  }

  function _doSafeTransferAcceptanceCheck(
    address operator,
    address from,
    address to,
    uint256 id,
    uint256 amount,
    bytes memory data
  ) internal {
    if (to.isContract()) {
      try
        IERC1155ReceiverUpgradeable(to).onERC1155Received(operator, from, id, amount, data)
      returns (bytes4 response) {
        if (response != IERC1155ReceiverUpgradeable(to).onERC1155Received.selector) {
          revert(Errors.VL_RECEIVER_REJECT_1155);
        }
      } catch Error(string memory reason) {
        revert(reason);
      } catch {
        revert(Errors.VL_RECEIVER_CONTRACT_NON_1155);
      }
    }
  }

  function _doSafeBatchTransferAcceptanceCheck(
    address operator,
    address from,
    address to,
    uint256[] memory ids,
    uint256[] memory amounts,
    bytes memory data
  ) internal {
    if (to.isContract()) {
      try
        IERC1155ReceiverUpgradeable(to).onERC1155BatchReceived(operator, from, ids, amounts, data)
      returns (bytes4 response) {
        if (response != IERC1155ReceiverUpgradeable(to).onERC1155BatchReceived.selector) {
          revert(Errors.VL_RECEIVER_REJECT_1155);
        }
      } catch Error(string memory reason) {
        revert(reason);
      } catch {
        revert(Errors.VL_RECEIVER_CONTRACT_NON_1155);
      }
    }
  }

  /**
   * @dev Hook that is called before any token transfer. This includes minting
   * and burning, as well as batched variants.
   *
   * The same hook is called on both single and batched variants. For single
   * transfers, the length of the `id` and `amount` arrays will be 1.
   *
   * Calling conditions (for each `id` and `amount` pair):
   *
   * - When `from` and `to` are both non-zero, `amount` of ``from``'s tokens
   * of token type `id` will be  transferred to `to`.
   * - When `from` is zero, `amount` tokens of token type `id` will be minted
   * for `to`.
   * - when `to` is zero, `amount` of ``from``'s tokens of token type `id`
   * will be burned.
   * - `from` and `to` are never both zero.
   * - `ids` and `amounts` have the same, non-zero length.
   *
   * To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
   */
  function _beforeTokenTransfer(
    address operator,
    address from,
    address to,
    uint256[] memory ids,
    uint256[] memory amounts,
    bytes memory data
  ) internal virtual {}

  function _asSingletonArray(uint256 element) private pure returns (uint256[] memory) {
    uint256[] memory array = new uint256[](1);
    array[0] = element;

    return array;
  }
}
