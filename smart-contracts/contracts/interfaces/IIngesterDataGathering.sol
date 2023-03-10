// SPDX-License-Identifier: MIT
pragma solidity 0.8.14;

interface IIngesterDataGathering {
    struct IpfsHash {
        string usersIpfsHash;
        string chatsIpfsHash;
        string messagesIpfsHash;
    }

    event IpfsHashAdded(address indexed ingesterAddress, string usersIpfsHash, string chatsIpfsHash, string messagesIpfsHash);
    
    function addIpfsHash(address ingesterAddress, string memory usersHash, string memory chatsHash, string memory messagesHash ) external;
    function getIpfsHashes(address ingesterAddress) external view returns(IpfsHash memory ipfsHashes);

}