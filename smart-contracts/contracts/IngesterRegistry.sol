// SPDX-License-Identifier: MIT
pragma solidity 0.8.14;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "hardhat/console.sol";
import "@openzeppelin/contracts/access/AccessControlEnumerable.sol";
import "./interfaces/IIngesterRegistry.sol";


contract IngesterRegistry is Ownable, AccessControlEnumerable, IngesterRegistryInterface, IIntegerRegistration {
    bytes32 public constant INGESTER_ROLE = keccak256("INGESTER_ROLE"); 

    constructor(uint16 maxNumberIngesterPerGroup) {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _maxNumberIngesterPerGroup = maxNumberIngesterPerGroup;
    }
    
    // New
    mapping(address => IngesterRegistryInterface.Ingester[]) public _ingesters;
    mapping(address => IngesterRegistryInterface.IpfsHash) private _ipfsHashes;
    mapping(uint => IngesterRegistryInterface.GroupToIngesterWithIndex) private _groups;
    mapping(address => IngesterRegistryInterface.IngesterToController) public _registeredIngesterToController;

    uint16 public _maxNumberIngesterPerGroup;
    uint public _groupCount;

    //modifiers
    modifier onlyAdmin() {
        require(hasRole(DEFAULT_ADMIN_ROLE, msg.sender), "Only admin can perform this action.");
        _;
    }

    modifier onlyRegistered() {
        require(hasRole(INGESTER_ROLE, msg.sender), "Caller is not a registered ingester");
        _;
    }

    //Functions

    function transferOwnership(address newOwner) public onlyAdmin override {
        super.transferOwnership(newOwner);
    }

    function addGroup(uint groupId) public onlyAdmin {
        require(!_groups[groupId].isAdded, "Group already exists.");
        IngesterRegistryInterface.GroupToIngesterWithIndex storage _defaultGroupToIngesterWithIndex = _groups[groupId];
        _defaultGroupToIngesterWithIndex.isAdded = true;
        _groupCount++;
        emit IngesterRegistryInterface.GroupAdded(groupId);
    }

    function removeGroup(uint groupId) public onlyAdmin {
        require(_groups[groupId].isAdded, "Group does not exist.");
        address[] memory ingesterAddresses = _groups[groupId].ingesterAddresses;
        removingGroupFromIngesters(groupId, ingesterAddresses); //gas intensive
        _groups[groupId].isAdded = false;
        _groupCount--;
        emit IngesterRegistryInterface.GroupRemoved(groupId);
    }

    function getGroup(uint groupId) public view returns (GroupToIngester memory) {
        IngesterRegistryInterface.GroupToIngester memory group = IngesterRegistryInterface.GroupToIngester(_groups[groupId].isAdded, _groups[groupId].ingesterAddresses);
        return group;
    }

    function getIngester(address ingesterAddress) public view returns (IngesterRegistryInterface.Ingester memory) {
        address controller = _registeredIngesterToController[ingesterAddress].controllerAddress;
        return _ingesters[controller][_registeredIngesterToController[ingesterAddress].ingesterIndex];
    }

    function getIpfsHashes(address ingesterAddress) public view returns(IpfsHash memory ipfsHashes) {
        return _ipfsHashes[ingesterAddress];
    }

    function setMaxNumberIngesterPerGroup(uint16 maxNumberIngesterPerGroup) external onlyAdmin {
        _maxNumberIngesterPerGroup = maxNumberIngesterPerGroup;
    }

   
    function removingIngesterFromGroups(uint[] memory groups, address ingesterAddress) public onlyRegistered {
        for (uint i = 0; i < groups.length; i++) {
            // These arrays are capped by the _maxNumberIngesterPerGroup
            for (uint j = 0; j < _groups[groups[i]].ingesterAddresses.length; j++) {
                if(_groups[groups[i]].ingesterAddresses[j] == ingesterAddress ) {
                    //delete ingesterAddress from _groups and readjust array length so _maxNumberIngesterPerGroup check remains truthful
                    for (uint z = j; z < _groups[groups[i]].ingesterAddresses.length-1; z++) {
                        _groups[groups[i]].ingesterAddresses[z] = _groups[groups[i]].ingesterAddresses[z+1];
                    }
                    _groups[groups[i]].ingesterAddresses.pop();
                    emit IngesterRegistryInterface.IngesterRemovedFromGroup(ingesterAddress, groups[i]);
                    break;
                }
            }
        }
    }

     function removingGroupFromIngesters(uint groupId, address[] memory ingesterAddresses) internal {
        for (uint i = 0; i < ingesterAddresses.length; i++) {
            address controllerAddress = _registeredIngesterToController[ingesterAddresses[i]].controllerAddress;
            uint ingesterIndex = _registeredIngesterToController[ingesterAddresses[i]].ingesterIndex;
            uint assignedGroupsIngesterIndex = _groups[groupId].assignedGroupsIngesterIndex[ingesterAddresses[i]];

            delete _ingesters[controllerAddress][ingesterIndex].assignedGroups[assignedGroupsIngesterIndex];
            emit IngesterRegistryInterface.GroupRemovedFromIngester(ingesterAddresses[i], groupId);
        }
    }

   
    //TODO: Modify this function to continually adjust the assignedGroups of ingesters
    // Goal of having each group being monitored by 3 different ingester. This would require a much more complex impl
    function getIngesterGroups(address ingesterAddress, uint[] memory groups) external onlyRegistered {
        require(_registeredIngesterToController[ingesterAddress].controllerAddress == msg.sender, "Only registered ingester controller can perform this action.");
        uint ingesterIndex = _registeredIngesterToController[ingesterAddress].ingesterIndex; // grab the ingesterIndex to avoid iteration
        for (uint256 i = 0; i < groups.length; i++) {
            //rule to make sure that only X different ingesters are monitoring the same group
            if (_groups[groups[i]].ingesterAddresses.length < _maxNumberIngesterPerGroup) {
                uint _currentAssignedGroupeIngesterIndex = 0;
                // if we already know which index it's in, avoid iterating through controller's available ingesterAddresses
                _ingesters[msg.sender][ingesterIndex].assignedGroups.push(groups[i]);
                _currentAssignedGroupeIngesterIndex = _ingesters[msg.sender][ingesterIndex].assignedGroups.length - 1;
                //update groups storage
                _groups[groups[i]].ingesterAddresses.push(ingesterAddress);
                _groups[groups[i]].assignedGroupsIngesterIndex[ingesterAddress] = _currentAssignedGroupeIngesterIndex; // save the assignedGroup index to save iterating later
            } else {
                revert(string(abi.encodePacked("Could not assign group as it exceeded the max number of ingester per group: ", groups[i])));
                // revert("Could not assign group as it exceeded the max number of ingester per group: ", groups[i]);
            }
        }

        emit IngesterRegistryInterface.IngesterRegisteredGroups(ingesterAddress, _ingesters[msg.sender][ingesterIndex].assignedGroups);
    }

    function addIpfsHash(address ingesterAddress, string memory usersHash, string memory chatsHash, string memory messagesHash ) external onlyRegistered {
        require(_registeredIngesterToController[ingesterAddress].controllerAddress == msg.sender, "Only registered ingester controller can perform this action.");

        // make struct with all the different type of hashes
        IpfsHash memory ipfsHashUsers = IngesterRegistryInterface.IpfsHash(usersHash, chatsHash, messagesHash);
        _ipfsHashes[ingesterAddress] = ipfsHashUsers;
        emit IngesterRegistryInterface.IpfsHashAdded(ingesterAddress, usersHash, chatsHash, messagesHash);
    }

    function registerIngester(
        address ingesterAddress,
        string memory message,
        uint256 nonce,
        bytes memory sig
        ) external {
        // require(_ingesters[msg.sender][_registeredIngesterToController[ingesterAddress].ingesterIndex].verified != true, "Ingestor already verified.");
        require(_registeredIngesterToController[ingesterAddress].controllerAddress != msg.sender, "Ingestor already registered.");

        bytes32 messageHash = _hash(ingesterAddress, message, nonce);

        bytes32 ethSignedMessageHash = getEthSignedMessageHash(messageHash);

        require(ECDSA.recover(ethSignedMessageHash, sig) == ingesterAddress, "Invalid signature."); // do the other way around

        Ingester memory ingester = IngesterRegistryInterface.Ingester(ingesterAddress, true, new uint[](0));

        _ingesters[msg.sender].push(ingester);
        _registeredIngesterToController[ingesterAddress].controllerAddress = msg.sender;
        _registeredIngesterToController[ingesterAddress].ingesterIndex = _ingesters[msg.sender].length - 1;

        _grantRole(INGESTER_ROLE, msg.sender);

        emit IIntegerRegistration.IngesterRegistered(msg.sender, ingesterAddress);
    }

    function unRegisteringIngester(address ingesterAddress) external onlyRegistered {
        require(_registeredIngesterToController[ingesterAddress].controllerAddress == msg.sender, "Ingestor is not registered with this controller address.");

        _registeredIngesterToController[ingesterAddress].controllerAddress = address(0);
        uint ingesterIndex = _registeredIngesterToController[ingesterAddress].ingesterIndex;

        removingIngesterFromGroups(_ingesters[msg.sender][ingesterIndex].assignedGroups, ingesterAddress);
        delete _ingesters[msg.sender][ingesterIndex]; // delete ingester 

        _registeredIngesterToController[ingesterAddress] = IngesterRegistryInterface.IngesterToController(address(0), 0); // delete controller from ingester

        // if this was the only ingester registered with this controller, remove their ingester role
        if (_ingesters[msg.sender].length > 0) {
            renounceRole("INGESTER_ROLE", msg.sender);
        }

        emit IIntegerRegistration.IngesterUnRegistered(msg.sender, ingesterAddress);
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
}
