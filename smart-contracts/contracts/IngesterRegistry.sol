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
        require(_ingestors[msg.sender].verified, "IngesterRegistry: Ingester is not registered");
        _;
    }


    //Change the bytes32 mapping with a ipfsHash structure
    struct ipfsHash {
        bytes32 ipfsHash;
        uint256 timestamp;
        bool verified;
    }

    struct Ingester {
        address ingesterAddress;
        bool verified;
    }

    mapping(address => Ingester) public _ingestors;
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

    function registerIngestor(
        address walletAddress,
        address ingestorAddress,
        uint256 amount,
        uint256 nonce,
        bytes memory sig
        ) external returns (bool) {
        require(_ingestors[walletAddress].verified == true, "ingestor already registered");
        bytes32 hash = _hash(walletAddress, amount, nonce);

        require(ECDSA.recover(hash, sig) == ingestorAddress, "Claim: Invalid signature");

        Ingester memory ingester = Ingester(ingestorAddress, true);

        _ingestors[walletAddress] = ingester;
        emit IngestorRegistered(walletAddress, ingestorAddress);
        return true;
    }

    function _hash(address _address, uint256 _value, uint256 _nonce) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(_address, _value, _nonce));
    }

    function recover(bytes32 hash, bytes memory sig) public pure returns (address){
        return ECDSA.recover(hash, sig);
    }

}
