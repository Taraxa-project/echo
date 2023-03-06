// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "hardhat/console.sol";
pragma abicoder v2;


contract IngesterRegistry is Ownable {

    address public admin;

    constructor() {
        admin = msg.sender;
    }
    
    //modifiers
    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action.");
        _;
    }

    modifier onlyRegistered() {
        require(_ingestors[msg.sender].verified, "IngesterRegistry: Ingester is not registered");
        _;
    }

    enum TYPE{USERS, CHATS, MESSAGES}

    struct IpfsHash {
        string ipfsHash;
        TYPE typeOfHash;
    }

    struct Ingester {
        address controllerAddress;
        bool verified;
        string[] assignedGroups;
    }

    mapping(address => Ingester) public _ingestors;
    mapping(string => bool) public _groups;
    string[] public _groupKeys;
    string[] public _unassignedGroups;
    mapping(string => bool) public _unassignedGroupsMap;
    address[] public _registeredIngestors;
    mapping(address => IpfsHash[]) public _ipfsHashes;

    //Events
    event GroupAdded(string groupUsername);
    event GroupRemoved(string groupUsername);
    event IngestorRegistered(address indexed walletAddress, address indexed ingestorAddress);
    event IngestorRegisteredGroups(address indexed ingestorAddress, string[] assignedGroups);
    event IpfsHashAdded(address indexed ingestorAddress, string ipfsHash, TYPE typeOfHash);

    //Functions
    function transferOwnership(address newOwner) public onlyAdmin override {
        super.transferOwnership(newOwner);
    }

    function addGroup(string memory groupUsername) public onlyAdmin {
        require(!_groups[groupUsername], "Group already exists.");
        _groups[groupUsername] = true;
        _groupKeys.push(groupUsername);
        _unassignedGroups.push(groupUsername);
        _unassignedGroupsMap[groupUsername] = true;
        emit GroupAdded(groupUsername);
    }

    function removeGroup(string memory groupUsername) public onlyAdmin {
        require(_groups[groupUsername], "Group does not exist.");
        _removeUnassignedGroup(groupUsername);
        _unassignedGroupsMap[groupUsername] = true;
        _groups[groupUsername] = false;
        _removeKey(groupUsername);
        emit GroupRemoved(groupUsername);
    }

    function getGroups() public view returns (string[] memory) {
        return _groupKeys;
    }

    function getIngesters() public view returns(address[] memory){
        return _registeredIngestors;
    }

    function ingestorCount() public view returns(uint){
        return _registeredIngestors.length;
    }

    function getUnassignedGroups() public view returns(string[] memory){
        return _unassignedGroups;
    }

    function getIngester(address ingesterAddr) public view returns (Ingester memory ingester){
        ingester = _ingestors[ingesterAddr];
        return ingester;
    }

    function getIpfsHashes(address ingesterAddress) public view returns(IpfsHash[] memory ipfsHashes) {
        return _ipfsHashes[ingesterAddress];
    }

    function _removeKey(string memory key) private {
        for (uint i = 0; i < _groupKeys.length; i++) {
            if (keccak256(bytes(_groupKeys[i])) == keccak256(bytes(key))) {
                _groupKeys[i] = _groupKeys[_groupKeys.length - 1];
                _groupKeys.pop();
                break;
            }
        }
    }

    function _removeUnassignedGroup(string memory group) private {
        require(_groups[group], "Group does not exist.");

        // Remove the group from the list of unassigned groups
        for (uint256 i =0; i < _unassignedGroups.length; i++) {
            if (keccak256(bytes(_unassignedGroups[i])) == keccak256(bytes(group))) {
                _unassignedGroups[i] = _unassignedGroups[_unassignedGroups.length - 1];
                _unassignedGroups.pop();
                break;
            }
        }
    }

    function registerIngestor(
        address ingesterAddress,
        string memory message,
        uint256 nonce,
        bytes memory sig
        ) external {
        require(_ingestors[ingesterAddress].controllerAddress != msg.sender, "Ingestor already registered.");

        bytes32 messageHash = _hash(msg.sender, message, nonce);

        bytes32 ethSignedMessageHash = getEthSignedMessageHash(messageHash);

        require(ECDSA.recover(ethSignedMessageHash, sig) == ingesterAddress);

        Ingester memory ingester = Ingester(msg.sender, true, new string[](0));

        _ingestors[ingesterAddress] = ingester;
        _registeredIngestors.push(ingesterAddress);
        emit IngestorRegistered(ingesterAddress, msg.sender);
    }

    function _hash(address _address, string memory _value, uint256 _nonce) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(_address, _value, _nonce));
    }

    function recover(bytes32 messageHash, bytes memory sig) public pure returns (address){
        return ECDSA.recover(messageHash, sig);
    }

    function getEthSignedMessageHash(
        bytes32 _messageHash
    ) public pure returns (bytes32) {
        /*
        Signature is produced by signing a keccak256 hash with the following format:
        "\x19Ethereum Signed Message\n" + len(msg) + msg
        */
        return
            keccak256(
                abi.encodePacked("\x19Ethereum Signed Message:\n32", _messageHash)
            );
    }

    function getIngesterGroups(address ingesterAddress) external returns (string[] memory) {
        require(_ingestors[ingesterAddress].controllerAddress == msg.sender, "Only registered ingester controller can perform this action.");

        uint256 numIngesters = _registeredIngestors.length;
        uint256 numGroups = _groupKeys.length;

        // calculate the number of groups per ingester
        uint256 groupsPerIngester = numGroups / numIngesters;

        // If there are more ingesters than groups, assign each ingester to one group
        if (groupsPerIngester == 0) {
            groupsPerIngester = 1;
        }

        // assign unassigned groups to the current ingester
        for (uint256 i = 0; i < groupsPerIngester; i++) {
            if (_unassignedGroups.length == 0) {
                revert('All groups have been assigned.');
                break;
            }
            string memory group = _unassignedGroups[_unassignedGroups.length -1];
            _unassignedGroups.pop();
            _unassignedGroupsMap[group] = false;
            _ingestors[ingesterAddress].assignedGroups.push(group);
        }
        emit IngestorRegisteredGroups(ingesterAddress, _ingestors[ingesterAddress].assignedGroups);
    }

    function addIpfsHash(address ingesterAddress, string memory usersHash, string memory chatsHash, string memory messagesHash ) external {
        require(_ingestors[ingesterAddress].controllerAddress == msg.sender, "Only registered ingester controller can perform this action.");

        delete _ipfsHashes[ingesterAddress];

        IpfsHash memory ipfsHashUsers = IpfsHash(usersHash, TYPE.USERS);
        _ipfsHashes[ingesterAddress].push(ipfsHashUsers);
        emit IpfsHashAdded(ingesterAddress, usersHash, TYPE.USERS);

        IpfsHash memory ipfsHashChats= IpfsHash(chatsHash, TYPE.CHATS);
        _ipfsHashes[ingesterAddress].push(ipfsHashChats);
        emit IpfsHashAdded(ingesterAddress, chatsHash, TYPE.CHATS);

        IpfsHash memory ipfsHashMessages = IpfsHash(messagesHash, TYPE.MESSAGES);
        _ipfsHashes[ingesterAddress].push(ipfsHashMessages);
        emit IpfsHashAdded(ingesterAddress, messagesHash, TYPE.MESSAGES);
    }
}
