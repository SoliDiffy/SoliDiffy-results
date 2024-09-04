pragma solidity ^0.6.0;

import "../RegistryEntry.sol";


contract Dataset is RegistryEntry
{
	/**
	 * Members
	 */
	string  internal m_datasetName;
	bytes   internal m_datasetMultiaddr;
	bytes32 internal m_datasetChecksum;

	/**
	 * Constructor
	 */
	function initialize(
		string  memory _datasetName,
		bytes   memory _datasetMultiaddr,
		bytes32        _datasetChecksum)
	public
	{
		_initialize(msg.sender);
		m_datasetName      = _datasetName;
		m_datasetMultiaddr = _datasetMultiaddr;
		m_datasetChecksum  = _datasetChecksum;
	}
}
