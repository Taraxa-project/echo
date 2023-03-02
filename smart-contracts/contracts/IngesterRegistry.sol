// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

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
        require(_ingestors[msg.sender], "IngesterRegistry: Ingester is not registered");
        _;
    }


    //Change the bytes32 mapping with a ipfsHash structure
    struct ipfsHash {
        bytes32 ipfsHash;
        uint256 timestamp;
        bool verified;
    }

    mapping(address => bool) public _ingestors;
    mapping(string => bool) public _groups;


    //Events
    event HashWritten(address indexed ingester, bytes32 indexed hash);
    event GroupAdded(string groupUsername);
    event GroupRemoved(string groupUsername);
    event IngestorRegistered(address indexed walletAddress, address indexed ingestorAddress);


    //Functions

    //Admin Flow
    function transferOwnership(address newOwner) public onlyAdmin override {
        super.transferOwnership(newOwner);
    }

    function addGroup(string memory groupUsername) public onlyAdmin {
        require(!_groups[groupUsername], "Group already exists.");
        _groups[groupUsername] = true;
        emit GroupAdded(groupUsername);
    }

    function removeGroup(string memory groupUsername) public onlyAdmin {
        require(_groups[groupUsername], "Group does not exist.");
        _groups[groupUsername] = false;
        emit GroupRemoved(groupUsername);
    }

    //Ingester Node Registration Flow

    // function registerIngestor(address walletAddress, bytes memory proof) public returns (bool) {
    //     bytes32 hash = keccak256(abi.encodePacked(walletAddress));
    //     address signer = ECDSA.recover(hash, proof);
    //     require(signer == msg.sender, "Invalid proof.");

    //     _ingestors[walletAddress] = true;
    //     emit IngestorRegistered(walletAddress);
    //     return true;
    // }

    function registerIngestor(address walletAddress, address ingestorAddress, bytes memory proof) public returns (bool) {
        require(_ingestors[ingestorAddress] == true, "ingestor already registered");
        bytes32 hash = keccak256(abi.encodePacked(ingestorAddress));
        address signer = ECDSA.recover(hash, proof);
        require(signer == walletAddress, "Invalid proof.");

        _ingestors[ingestorAddress] = true;
        emit IngestorRegistered(walletAddress, ingestorAddress);
        return true;
    }

}
