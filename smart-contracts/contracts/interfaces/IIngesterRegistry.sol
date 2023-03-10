// SPDX-License-Identifier: MIT
pragma solidity 0.8.14;

interface IngesterRegistryInterface {
    
    struct IpfsHash {
        string usersIpfsHash;
        string chatsIpfsHash;
        string messagesIpfsHash;
    }

    struct Ingester {
        address ingesterAddress;
        bool verified;
        uint256[] assignedGroups;
    }

    struct GroupToIngesterWithIndex{
        bool isAdded;
        address[] ingesterAddresses;
        mapping(address => uint) assignedGroupsIngesterIndex;
    }

    struct GroupToIngester{
        bool isAdded;
        address[] ingesterAddresses;
    }

    struct IngesterToController {
        address controllerAddress;
        uint ingesterIndex;
    }

    // Events
    event GroupAdded(uint groupUsername);
    event GroupRemoved(uint groupUsername);
    event GroupRemovedFromIngester(address indexed ingesterAddress, uint group);

    event IngesterRemovedFromGroup(address indexed ingesterAddress, uint indexed groupId);
    event IngesterRegisteredGroups(address indexed ingesterAddress, uint[] assignedGroups);
    event IpfsHashAdded(address indexed ingesterAddress, string usersIpfsHash, string chatsIpfsHash, string messagesIpfsHash);

    // Functions
    // function transferContractOwnership(address newOwner) external;
    function addGroup(uint groupId) external;
    function removeGroup(uint groupId) external;
    function getGroup(uint groupId) external view returns (GroupToIngester memory);
    function getIpfsHashes(address ingesterAddress) external view returns(IpfsHash memory ipfsHashes);
    function setMaxNumberIngesterPerGroup(uint16 maxNumberIngesterPerGroup) external;
    
    // function removingIngesterFromGroups(uint[] memory groups, address ingesterAddress) public;
    // function removingGroupFromIngesters(uint groupId, address[] memory ingesterAddresses) external;
    function getIngesterGroups(address ingesterAddress, uint[] memory groups) external;
    function addIpfsHash(address ingesterAddress, string memory usersHash, string memory chatsHash, string memory messagesHash ) external;
}

interface IIntegerRegistration {
    event IngesterRegistered(address indexed controllerAddress, address indexed ingesterAddress);
    event IngesterUnRegistered(address indexed controllerAddress, address indexed ingesterAddress);

    function _hash(address _address, string memory _value, uint256 _nonce) external pure returns (bytes32);
    function recover(bytes32 messageHash, bytes memory sig) external pure returns (address);
    function getEthSignedMessageHash(bytes32 _messageHash) external pure returns (bytes32);
    function registerIngester(
        address ingesterAddress,
        string memory message,
        uint256 nonce,
        bytes memory sig
        ) external;
    function unRegisteringIngester(address ingesterAddress) external;
}