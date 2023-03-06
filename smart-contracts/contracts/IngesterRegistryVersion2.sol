// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.0;

// import "@openzeppelin/contracts/access/Ownable.sol";
// import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

// contract IngesterRegistry is Ownable {

//      address public admin;
//     uint public numIngestors;

//     constructor() {
//         admin = msg.sender;
//         numIngestors = 0;
//     }
    
//     //modifiers
//     modifier onlyAdmin() {
//         require(msg.sender == admin, "Only admin can perform this action.");
//         _;
//     }

//     modifier onlyRegistered() {
//         require(_ingestors[msg.sender].verified, "IngesterRegistry: Ingester is not registered");
//         _;
//     }

//     //Change the bytes32 mapping with a ipfsHash structure
//     struct ipfsHash {
//         bytes32 ipfsHash;
//         uint256 timestamp;
//         bool verified;
//     }

//     struct Ingester {
//         address ingesterAddress;
//         bool verified;
//         uint256 groupOffset;
//         uint256 numGroups;
//     }

//     mapping(address => Ingester) public _ingestors;
//     mapping(string => bool) public _groups;
//     mapping(string => address) public _groupAssignments;
//     string[] public _groupKeys;

//     //Events
//     event HashWritten(address indexed ingester, bytes32 indexed hash);
//     event GroupAdded(string groupUsername);
//     event GroupRemoved(string groupUsername);
//     event IngestorRegistered(address indexed walletAddress, address indexed ingestorAddress);


//     //Functions
//     //Admin Flow
//     function transferOwnership(address newOwner) public onlyAdmin override {
//         super.transferOwnership(newOwner);
//     }

//     function addGroup(string memory groupUsername) public onlyAdmin {
//         require(!_groups[groupUsername], "Group already exists.");
//         _groups[groupUsername] = true;
//         _groupKeys.push(groupUsername);
//         emit GroupAdded(groupUsername);
//     }

//     function removeGroup(string memory groupUsername) public onlyAdmin {
//         require(_groups[groupUsername], "Group does not exist.");
//         _groups[groupUsername] = false;
//         _removeKey(groupUsername);
//         emit GroupRemoved(groupUsername);
//     }

//     function listGroups() public view returns (string[] memory) {
//         return _groupKeys;
//     }

//     function _removeKey(string memory key) private {
//         for (uint i = 0; i < _groupKeys.length; i++) {
//             if (keccak256(bytes(_groupKeys[i])) == keccak256(bytes(key))) {
//                 _groupKeys[i] = _groupKeys[_groupKeys.length - 1];
//                 _groupKeys.pop();
//                 break;
//             }
//         }
//     }

//     //Ingester Node Registration Flow
//     function registerIngestor(
//         address ingestorAddress,
//         string memory message,
//         uint256 nonce,
//         bytes memory sig
//         ) external {
//         bytes32 messageHash = _hash(ingestorAddress, message, nonce);

//         bytes32 ethSignedMessageHash = getEthSignedMessageHash(messageHash);

//         require(ECDSA.recover(ethSignedMessageHash, sig) == ingestorAddress, "Claim: Invalid signature.");

//         Ingester memory ingester = Ingester(ingestorAddress, true);

//         _ingestors[msg.sender] = ingester;
//         emit IngestorRegistered(msg.sender, ingestorAddress);
//     }

//     function _hash(address _address, string memory _value, uint256 _nonce) public pure returns (bytes32) {
//         return keccak256(abi.encodePacked(_address, _value, _nonce));
//     }

//     function recover(bytes32 messageHash, bytes memory sig) public pure returns (address){
//         return ECDSA.recover(messageHash, sig);
//     }

//     function getMessageHash(
//         address _to,
//         uint _amount,
//         string memory _message,
//         uint _nonce
//     ) public pure returns (bytes32) {
//         return keccak256(abi.encodePacked(_to, _amount, _message, _nonce));
//     }

//     function getEthSignedMessageHash(
//         bytes32 _messageHash
//     ) public pure returns (bytes32) {
//         /*
//         Signature is produced by signing a keccak256 hash with the following format:
//         "\x19Ethereum Signed Message\n" + len(msg) + msg
//         */
//         return
//             keccak256(
//                 abi.encodePacked("\x19Ethereum Signed Message:\n32", _messageHash)
//             );
//     }

//     function get_ingester_groups(address ingesterAddress) public view returns (string[] memory) {
//         require(_ingestors[ingesterAddress].verified, "Ingester is not registered");
//         require(_ingestors[ingesterAddress].ingesterAddress == msg.sender, "Only ingester can perform this action.");

//         uint numGroups = _groupKeys.length;
//         uint numIngestors = 0;
//         for (uint i = 0; i < _ingestorAddresses.length; i++) {
//             if (_ingestors[_ingestorAddresses[i]].verified) {
//                 numIngestors++;
//             }
//         }

//         require(numIngestors > 0, "No registered ingestors");

//         uint numGroupsPerIngestor = numGroups / numIngestors;

//         // Calculate the number of groups for this ingester
//         uint startIndex = uint(uint160(ingesterAddress)) % numIngestors;
//         uint numGroupsForIngestor = numGroupsPerIngestor;
//         if (startIndex < (numGroups % numIngestors)) {
//             numGroupsForIngestor++;
//         }

//         string[] memory assignedGroups = new string[](numGroupsForIngestor);

//         // Assign groups to this ingester
//         uint assignedIndex = 0;
//         for (uint i = 0; i < numGroups; i++) {
//             if (assignedIndex >= numGroupsForIngestor) {
//                 break;
//             }
//             if ((i + startIndex) % numIngestors == 0) {
//                 assignedGroups[assignedIndex] = _groupKeys[i];
//                 assignedIndex++;
//             }
//         }

//         return assignedGroups;
//     }

//     function get_ingester_groups(address ingesterAddress) public onlyRegistered returns (string[] memory) {
//     Ingester memory ingester = _ingestors[ingesterAddress];
//     require(ingester.ingesterAddress != address(0), "Ingester does not exist.");

//     uint numGroups = _groupKeys.length;
//     uint numIngestors = _getNumIngestors();

//     uint256 startingIndex = uint256(keccak256(abi.encodePacked(blockhash(block.number - 1), msg.sender))) % numGroups;
//     uint256 currentIndex = startingIndex;
//     uint256 assignedGroups = 0;

//     string[] memory assignedGroupKeys = new string[](numGroups / numIngestors);

//     while (assignedGroups < assignedGroupKeys.length) {
//         string memory groupKey = _groupKeys[currentIndex];
//         if (!_ingesterHasGroup(ingesterAddress, groupKey)) {
//             assignedGroupKeys[assignedGroups] = groupKey;
//             _assignGroupToIngester(ingesterAddress, groupKey);
//             assignedGroups++;
//         }
//         currentIndex = (currentIndex + 1) % numGroups;
//         if (currentIndex == startingIndex) {
//             break;
//         }
//     }

//     return assignedGroupKeys;
// }

// function _getTotalAssignedGroups() private view returns (uint256) {
//     uint256 total = 0;
//     for (uint256 i = 0; i < _groupKeys.length; i++) {
//         if (_assignedGroupToIngester(_groupKeys[i])) {
//             total++;
//         }
//     }
//     return total;
// }

// function _getMaxAssignedGroups() private view returns (uint256) {
//     uint256 numIngestors = _getNumIngestors();
//     return (_groupKeys.length / numIngestors);
// }

// function _getNumIngestors() private view returns (uint256) {
//     uint256 count = 0;
//     for (uint256 i = 0; i < _groupKeys.length; i++) {
//         if (_ingesterHasGroup(_ingestors[msg.sender].ingesterAddress, _groupKeys[i])) {
//             count++;
//         }
//     }
//     return count;
// }

// function _assignedGroupToIngester(string memory groupKey) private view returns (bool) {
//     for (uint256 i = 0; i < _groupKeys.length; i++) {
//         if (_ingesterHasGroup(_ingestors[msg.sender].ingesterAddress, _groupKeys[i])) {
//             return true;
//         }
//     }
//     return false;
// }

// function _ingesterHasGroup(address ingesterAddress, string memory groupKey) private view returns (bool) {
//     return _ingesters[ingesterAddress].assignedGroups[groupKey];
// }

// function _assignGroupToIngester(address ingesterAddress, string memory groupKey) private {
//     _ingesters[ingesterAddress].assignedGroups[groupKey] = true;
// }



// }
