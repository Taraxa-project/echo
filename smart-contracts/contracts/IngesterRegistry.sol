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
        string[] assignedGroups;
    }

    mapping(address => Ingester) public _ingestors;
    mapping(string => bool) public _groups;
    string[] public _groupKeys;
    address[] public _registeredIngestors;

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
        _groupKeys.push(groupUsername);
        emit GroupAdded(groupUsername);
    }

    function removeGroup(string memory groupUsername) public onlyAdmin {
        require(_groups[groupUsername], "Group does not exist.");
        _groups[groupUsername] = false;
        _removeKey(groupUsername);
        emit GroupRemoved(groupUsername);
    }

    function listGroups() public view returns (string[] memory) {
        return _groupKeys;
    }

    function listIngestors() public view returns(address[] memory){
        return _registeredIngestors;
    }

    function ingestorCount() public view returns(uint){
        return _registeredIngestors.length;
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

        Ingester memory ingester = Ingester(ingestorAddress, true, new string[](0));

        _ingestors[msg.sender] = ingester;
        _registeredIngestors.push(ingestorAddress);
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

    //this version may be more gas efficient by maintaining an upside down mapping _ingestorByGroup
    // function get_ingester_groups(address ingesterAddress) public view returns (string memory) {
    //     require(_ingestors[ingesterAddress].verified, "Ingester is not registered");
    //     require(_ingestors[ingesterAddress].ingesterAddress == msg.sender, "Only ingester can perform this action.");
        
    //     uint256 numGroups = _groupKeys.length;
    //     uint256 numIngestors = ingestorCount();
    //     //generates a pseudorandom index into the array of groups, based on the current timestamp and the msg.sender address.
    //     //results in a value between - and numGroups - 1
    //     uint256 groupIndex = uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender))) % numGroups;
    //     string memory groupKey = _groupKeys[groupIndex];

    //     for (uint256 i = 0; i < numIngestors; i++) {
    //         uint256 currentIndex = (groupIndex + i) % numGroups;
    //         string memory currentGroup = _groupKeys[currentIndex];
    //         address currentIngestor = _ingestorsByGroup[currentGroup];
    //         if (currentIngestor == address(0)) {
    //             // no ingester assigned to this group yet
    //             _ingestorsByGroup[currentGroup] = ingesterAddress;
    //             _ingestors[ingesterAddress].assignedGroup = currentGroup;
    //             return currentGroup;
    //         } else if (currentIngestor == ingesterAddress) {
    //             // ingester already assigned to this group
    //             return currentGroup;
    //         }
    //     }
    //     // should never get here
    //     revert("Failed to assign group to ingester");
    // }

    function getIngesterGroups(address ingesterAddress) public view returns (string[] memory) {
        require(_ingestors[ingesterAddress].verified, "Ingester is not registered");
        require(_ingestors[ingesterAddress].ingesterAddress == msg.sender, "Only ingester can perform this action.");

        uint256 numGroups = _groupKeys.length;
        string[] memory assignedGroups = new string[](numGroups);
        uint256 assignedCount = 0;

        for (uint256 i = 0; i < numGroups; i++) {
            string memory currentGroup = _groupKeys[i];
            bool groupAssigned = false;

            // Check whether the current group is already assigned to an ingester
            for (uint256 j = 0; j < _registeredIngestors.length; j++) {
                Ingester storage ingester = _ingestors[_registeredIngestors[j]];
                for (uint256 k = 0; k < ingester.assignedGroups.length; k++) {
                    if (keccak256(bytes(ingester.assignedGroups[k])) == keccak256(bytes(currentGroup))) {
                        groupAssigned = true;
                        break;
                    }
                }
                if (groupAssigned) {
                    break;
                }
            }

            // Assign the current group to the current ingester if it's not already assigned
            if (!groupAssigned) {
                assignedGroups[assignedCount] = currentGroup;
                assignedCount++;
                if (assignedCount >= numGroups / ingestorCount()) {
                    break; // Exit the loop if the maximum number of groups per ingester is reached
                }
            }
        }

        // Trim the assignedGroups array to remove any empty elements at the end
        string[] memory result = new string[](assignedCount);
        for (uint256 i = 0; i < assignedCount; i++) {
            result[i] = assignedGroups[i];
        }

        return result;  
    }
}
