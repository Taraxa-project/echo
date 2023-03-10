
// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.14;

import "./interfaces/IIngesterDataGathering.sol";
import "./IngesterRegistryAccessControl.sol";

contract IngesterDataGathering is  IngesterRegistryAccessControl, IIngesterDataGathering {
    mapping(address => IIngesterDataGathering.IpfsHash) public _ipfsHashes;

    function addIpfsHash(address ingesterAddress, string memory usersHash, string memory chatsHash, string memory messagesHash ) external onlyRegistered {
        // make struct with all the different type of hashes
        IIngesterDataGathering.IpfsHash memory ipfsHashUsers = IIngesterDataGathering.IpfsHash(usersHash, chatsHash, messagesHash);
        _ipfsHashes[ingesterAddress] = ipfsHashUsers;
        emit IIngesterDataGathering.IpfsHashAdded(ingesterAddress, usersHash, chatsHash, messagesHash);
    }

    function getIpfsHashes(address ingesterAddress) public view returns(IpfsHash memory ipfsHashes) { // IpfsHash which interface would this belong to 
        return _ipfsHashes[ingesterAddress];
    }
}