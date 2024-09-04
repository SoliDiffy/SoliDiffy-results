// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.6.0 <0.7.0;
pragma experimental ABIEncoderV2;

import "../token/ControlledTokenProxyFactory.sol";
import "../token/TicketProxyFactory.sol";

/* solium-disable security/no-block-members */
contract ControlledTokenBuilder {

  event CreatedControlledToken(address indexed token);
  event CreatedTicket(address indexed token);

  ControlledTokenProxyFactory public controlledTokenProxyFactory;
  TicketProxyFactory public ticketProxyFactory;

  struct ControlledTokenConfig {
    string name;
    string symbol;
    uint8 decimals;
    TokenControllerInterface controller;
  }

  

  function createControlledToken(
    ControlledTokenConfig calldata config
  ) external returns (ControlledToken) {
    ControlledToken token = controlledTokenProxyFactory.create();

    token.initialize(
      config.name,
      config.symbol,
      config.decimals,
      config.controller
    );

    emit CreatedControlledToken(address(token));

    return token;
  }

  function createTicket(
    ControlledTokenConfig calldata config
  ) external returns (Ticket) {
    Ticket token = ticketProxyFactory.create();

    token.initialize(
      config.name,
      config.symbol,
      config.decimals,
      config.controller
    );

    emit CreatedTicket(address(token));

    return token;
  }
}
