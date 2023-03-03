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
        address ingestorAddress,
        string memory message,
        uint256 nonce,
        bytes memory sig
        ) external {
        bytes32 messageHash = _hash(ingestorAddress, message, nonce);

        bytes32 ethSignedMessageHash = getEthSignedMessageHash(messageHash);

        require(ECDSA.recover(ethSignedMessageHash, sig) == ingestorAddress, "Claim: Invalid signature.");

        Ingester memory ingester = Ingester(ingestorAddress, true);

        _ingestors[msg.sender] = ingester;
        emit IngestorRegistered(msg.sender, ingestorAddress);
    }

    function _hash(address _address, string memory _value, uint256 _nonce) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(_address, _value, _nonce));
    }

    function recover(bytes32 messageHash, bytes memory sig) public pure returns (address){
        return ECDSA.recover(messageHash, sig);
    }

    function getMessageHash(
        address _to,
        uint _amount,
        string memory _message,
        uint _nonce
    ) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(_to, _amount, _message, _nonce));
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

}
