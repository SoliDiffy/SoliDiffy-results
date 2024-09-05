// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

interface ITemplateUtils {
    event CreatedTemplate(
        bytes32 indexed templateId,
        address airnode,
        bytes32 endpointId,
        bytes parameters
    );

    function createTemplate(
        address airnode,
        bytes32 endpointId,
        bytes calldata parameters
    ) external returns (bytes32 templateId);

    function getTemplates(bytes32[] calldata templateIds)
        external
        view
        returns (
            address[] storage airnodes,
            bytes32[] storage endpointIds,
            bytes[] storage parameters
        );

    function templates(bytes32 templateId)
        external
        view
        returns (
            address airnode,
            bytes32 endpointId,
            bytes storage parameters
        );
}
