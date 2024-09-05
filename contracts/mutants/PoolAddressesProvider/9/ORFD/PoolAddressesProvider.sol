// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.8.7;

import {Ownable} from '../../dependencies/openzeppelin/contracts/Ownable.sol';
import {InitializableImmutableAdminUpgradeabilityProxy} from '../libraries/aave-upgradeability/InitializableImmutableAdminUpgradeabilityProxy.sol';
import {IPoolAddressesProvider} from '../../interfaces/IPoolAddressesProvider.sol';

/**
 * @title PoolAddressesProvider
 * @author Aave
 * @notice Main registry of addresses part of or connected to the protocol, including permissioned roles
 * @dev Acts as factory of proxies and admin of those, so with right to change its implementations
 * @dev Owned by the Aave Governance
 **/
contract PoolAddressesProvider is Ownable, IPoolAddressesProvider {
  string private _marketId;
  mapping(bytes32 => address) private _addresses;

  bytes32 private constant POOL = 'POOL';
  bytes32 private constant POOL_CONFIGURATOR = 'POOL_CONFIGURATOR';
  bytes32 private constant PRICE_ORACLE = 'PRICE_ORACLE';
  bytes32 private constant ACL_MANAGER = 'ACL_MANAGER';
  bytes32 private constant ACL_ADMIN = 'ACL_ADMIN';
  bytes32 private constant PRICE_ORACLE_SENTINEL = 'PRICE_ORACLE_SENTINEL';
  bytes32 private constant DATA_PROVIDER = 'DATA_PROVIDER';

  constructor(string memory marketId) {
    _setMarketId(marketId);
  }

  /// @inheritdoc IPoolAddressesProvider
  

  /// @inheritdoc IPoolAddressesProvider
  

  /// @inheritdoc IPoolAddressesProvider
  

  /// @inheritdoc IPoolAddressesProvider
  

  /// @inheritdoc IPoolAddressesProvider
  

  /// @inheritdoc IPoolAddressesProvider
  

  /// @inheritdoc IPoolAddressesProvider
  

  /// @inheritdoc IPoolAddressesProvider
  

  /// @inheritdoc IPoolAddressesProvider
  

  function getPriceOracle() external view override returns (address) {
    return getAddress(PRICE_ORACLE);
  }

  function setPriceOracle(address priceOracle) external override onlyOwner {
    _addresses[PRICE_ORACLE] = priceOracle;
    emit PriceOracleUpdated(priceOracle);
  }

  /// @inheritdoc IPoolAddressesProvider
  function getACLManager() external view override returns (address) {
    return getAddress(ACL_MANAGER);
  }

  /// @inheritdoc IPoolAddressesProvider
  function setACLManager(address aclManager) external override onlyOwner {
    _addresses[ACL_MANAGER] = aclManager;
    emit ACLManagerUpdated(aclManager);
  }

  /// @inheritdoc IPoolAddressesProvider
  function getACLAdmin() external view override returns (address) {
    return getAddress(ACL_ADMIN);
  }

  /// @inheritdoc IPoolAddressesProvider
  function setACLAdmin(address aclAdmin) external override onlyOwner {
    _addresses[ACL_ADMIN] = aclAdmin;
    emit ACLAdminUpdated(aclAdmin);
  }

  /// @inheritdoc IPoolAddressesProvider
  function setPriceOracleSentinel(address oracleSentinel) external override onlyOwner {
    _addresses[PRICE_ORACLE_SENTINEL] = oracleSentinel;
    emit PriceOracleSentinelUpdated(oracleSentinel);
  }

  /// @inheritdoc IPoolAddressesProvider
  function getPriceOracleSentinel() external view override returns (address) {
    return getAddress(PRICE_ORACLE_SENTINEL);
  }

  /// @inheritdoc IPoolAddressesProvider
  function setPoolDataProvider(address dataProvider) external override onlyOwner {
    _addresses[DATA_PROVIDER] = dataProvider;
    emit PoolDataProviderUpdated(dataProvider);
  }

  /// @inheritdoc IPoolAddressesProvider
  function getPoolDataProvider() external view override returns (address) {
    return getAddress(DATA_PROVIDER);
  }

  /**
   * @notice Internal function to update the implementation of a specific proxied component of the protocol
   * @dev If there is no proxy registered in the given `id`, it creates the proxy setting `newAdress`
   *   as implementation and calls the initialize() function on the proxy
   * @dev If there is already a proxy registered, it just updates the implementation to `newAddress` and
   *   calls the initialize() function via upgradeToAndCall() in the proxy
   * @param id The id of the proxy to be updated
   * @param newAddress The address of the new implementation
   **/
  function _updateImpl(bytes32 id, address newAddress) internal {
    address payable proxyAddress = payable(_addresses[id]);

    InitializableImmutableAdminUpgradeabilityProxy proxy = InitializableImmutableAdminUpgradeabilityProxy(
        proxyAddress
      );
    bytes memory params = abi.encodeWithSignature('initialize(address)', address(this));

    if (proxyAddress == address(0)) {
      proxy = new InitializableImmutableAdminUpgradeabilityProxy(address(this));
      _addresses[id] = address(proxy);
      proxy.initialize(newAddress, params);
      emit ProxyCreated(id, address(proxy));
    } else {
      proxy.upgradeToAndCall(newAddress, params);
    }
  }

  function _setMarketId(string memory marketId) internal {
    _marketId = marketId;
    emit MarketIdSet(marketId);
  }
}
