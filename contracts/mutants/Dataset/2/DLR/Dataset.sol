pragma solidity ^0.6.0;

import "../RegistryEntry.sol";


contract Dataset is RegistryEntry
{
	/**
	 * Members
	 */
	string  public m_datasetName;
	bytes   public m_datasetMultiaddr;
	bytes32 public m_datasetChecksum;

	/**
	 * Constructor
	 */
	function initialize(
		string  storage _datasetName,
		bytes   storage _datasetMultiaddr,
		bytes32        _datasetChecksum)
	public
	{
		_initialize(msg.sender);
		m_datasetName      = _datasetName;
		m_datasetMultiaddr = _datasetMultiaddr;
		m_datasetChecksum  = _datasetChecksum;
	}
}
