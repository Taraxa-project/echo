// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.14;

import "../interfaces/IngesterOrchestratorV2/IIngesterDataGatheringV2.sol";
import "./IngesterRegistryAccessControlV2.sol";

contract IngesterDataGatheringV2 is
    IngesterRegistryAccessControlV2,
    IIngesterDataGatheringV2
{
    mapping(address => IIngesterDataGatheringV2.IpfsHash) public _ipfsHashes;

    function addIpfsHash(
        address ingesterAddress,
        string memory usersHash,
        string memory chatsHash,
        string memory messagesHash
    ) external onlyRegistered {
        // make struct with all the different type of hashes
        IIngesterDataGatheringV2.IpfsHash
            memory ipfsHashUsers = IIngesterDataGatheringV2.IpfsHash(
                usersHash,
                chatsHash,
                messagesHash
            );
        _ipfsHashes[ingesterAddress] = ipfsHashUsers;
        emit IIngesterDataGatheringV2.IpfsHashAdded(
            ingesterAddress,
            usersHash,
            chatsHash,
            messagesHash
        );
    }

    function getIpfsHashes(
        address ingesterAddress
    ) public view returns (IpfsHash memory ipfsHashes) {
        // IpfsHash which interface would this belong to
        return _ipfsHashes[ingesterAddress];
    }
}
