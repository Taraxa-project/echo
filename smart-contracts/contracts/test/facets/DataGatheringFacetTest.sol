
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./AccessControlFacetTest.sol";
import "./CommonFunctionsFacetTest.sol";
import "../../interfaces/IIngesterDataGathering.sol";
import { AppStorageTest } from "../libraries/LibAppStorageUpgradeTest.sol";

contract DataGatheringFacetTest is AccessControlFacetTest, CommonFunctionsFacetTest, IIngesterDataGathering {

     /**
     * @notice Adds IPFS hashes for a registered ingester.
     * @dev Can only be called by a registered ingester.
     * @param usersHash The IPFS hash of the users data.
     * @param chatsHash The IPFS hash of the chats data.
     * @param messagesHash The IPFS hash of the messages data.
     */
    function addIpfsHash(
        string calldata usersHash,
        string calldata chatsHash,
        string calldata messagesHash
    ) external onlyRegisteredIngester {
        address ingesterAddress = msg.sender;
        IpfsHash memory ipfsHashUsers = IpfsHash(
                usersHash,
                chatsHash,
                messagesHash
                );
        s.ipfsHashes[ingesterAddress] = ipfsHashUsers;
        emit IpfsHashAdded(
            ingesterAddress,
            usersHash,
            chatsHash,
            messagesHash
        );
    }

    /**
     * @notice Gets the IPFS hashes for a registered ingester.
     * @dev Can be called by anyone.
     * @param ingesterAddress The address of the registered ingester.
     * @return ipfsHashes The IPFS struct of the ingester's data hashes.
     */
    function getIpfsHashes(
        address ingesterAddress
    ) public view returns (IpfsHash memory ipfsHashes) {
        return s.ipfsHashes[ingesterAddress];
    }
}
