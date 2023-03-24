
// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.14;

import "../interfaces/IngesterOrchestratorV1/IIngesterDataGathering.sol";
import "./IngesterRegistryAccessControl.sol";

/**
 * @title IngesterDataGathering
 * @dev This contract manages the storage of IPFS hashes stored by registered ingesters.
 * It extends the IngesterRegistryAccessControl which manages access control and ownership for the Ingester Registry and IngesterDataGathering interface
 */
contract IngesterDataGathering is  IngesterRegistryAccessControl, IIngesterDataGathering {

    mapping(address => IIngesterDataGathering.IpfsHash) public _ipfsHashes;

    /**
     * @notice Adds IPFS hashes for a registered ingester.
     * @dev Can only be called by a registered ingester.
     * @param ingesterAddress The address of the registered ingester.
     * @param usersHash The IPFS hash of the users data.
     * @param chatsHash The IPFS hash of the chats data.
     * @param messagesHash The IPFS hash of the messages data.
     */
    function addIpfsHash(address ingesterAddress, string memory usersHash, string memory chatsHash, string memory messagesHash ) external onlyRegistered {
        // make struct with all the different type of hashes
        IIngesterDataGathering.IpfsHash memory ipfsHashUsers = IIngesterDataGathering.IpfsHash(usersHash, chatsHash, messagesHash);
        _ipfsHashes[ingesterAddress] = ipfsHashUsers;
        emit IIngesterDataGathering.IpfsHashAdded(ingesterAddress, usersHash, chatsHash, messagesHash);
    }

    /**
     * @notice Gets the IPFS hashes for a registered ingester.
     * @dev Can be called by anyone.
     * @param ingesterAddress The address of the registered ingester.
     * @return The IPFS hashes of the ingester's data.
     */
    function getIpfsHashes(address ingesterAddress) public view returns(IpfsHash memory ipfsHashes) { // IpfsHash which interface would this belong to 
        return _ipfsHashes[ingesterAddress];
    }
}