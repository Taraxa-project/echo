// SPDX-License-Identifier: MIT
pragma solidity 0.8.14;


import "../interfaces/IngesterOrchestratorV2/IIngesterOrchestratorV2.sol";
import "./IngesterRegistrationV2.sol";
import "./IngesterRegistryAccessControlV2.sol";
import "./IngesterDataGatheringV2.sol";
import "hardhat/console.sol";

contract IngesterOrchestratorV2 is IngesterRegistryAccessControlV2, IngesterRegistrationV2 , IIngesterOrchestratorV2{ //, IngesterDataGatheringV2 {

    constructor(uint256 maxNumberIngesterPerGroup) IngesterRegistryAccessControlV2(){
        _maxNumberIngesterPerGroup = maxNumberIngesterPerGroup;
    }

    mapping(string => IIngesterOrchestratorV2.GroupToIngesterWithIndex) private _groups;
    string[] public _groupUsernames;
    uint256 public _maxNumberIngesterPerGroup;
    uint256 public _groupCount;

    /**
    * @notice Adds a new group to the orchestrator.
    * @dev Emits a GroupAdded event upon successful addition of the group.
    * @param groupUsername The unique identifier (username) of the group to be added.
    */
    function addGroup(string memory groupUsername) public onlyAdmin {
        require(!_groups[groupUsername].isAdded, "Group already exists.");
        IIngesterOrchestratorV2.GroupToIngesterWithIndex storage _defaultGroupToIngesterWithIndex = _groups[groupUsername];
        _groupUsernames.push(groupUsername);
        _defaultGroupToIngesterWithIndex.isAdded = true;
        _defaultGroupToIngesterWithIndex.groupUsernameIndex = _groupUsernames.length -1;
        ++_groupCount;
        distributeGroup(groupUsername);
        emit IIngesterOrchestratorV2.GroupAdded(groupUsername);
    }

    /**
    * @notice Removes an existing group from the orchestrator.
    * @dev Emits a GroupRemoved event upon successful removal of the group.
    * @param groupUsername The unique identifier (username) of the group to be removed.
    */
    function removeGroup(string memory groupUsername) public onlyAdmin {
        require(_groups[groupUsername].isAdded, "Group does not exist.");
        address[] memory ingesterAddresses = _groups[groupUsername].ingesterAddresses;
        removingGroupFromIngesters(groupUsername, ingesterAddresses); //gas intensive
        _groups[groupUsername].isAdded = false;
        _groups[groupUsername].ingesterAddresses = new address[](0);
        delete _groupUsernames[_groups[groupUsername].groupUsernameIndex];
        --_groupCount;
        emit IIngesterOrchestratorV2.GroupRemoved(groupUsername);
    }

    /**
    * @notice Distributes a group among the registered ingesters.
    * @dev Used internally to balance the distribution of groups among ingesters.
    * @param groupUsername The unique identifier (username) of the group to be distributed.
    */
    function distributeGroup(string memory groupUsername) internal {
        //make sure it rounds up in this operation to allow for adding new groups when remainder > 0
        uint256 maxGroupsPerIngester = (_groupCount + _ingesterCount - 1) / _ingesterCount;
        // console.log("distributing group", groupUsername);
        for (uint256 i = 0; i < _ingesterAddresses.length; ++i) {
            // if it's not a deleted element of the array, then it must be a valid ingester
            if (_registeredIngesterToController[_ingesterAddresses[i]].controllerAddress == address(0)) {
                continue;
            }  else {
                address controllerAddress = _registeredIngesterToController[_ingesterAddresses[i]].controllerAddress;
                uint256 ingesterIndex = _registeredIngesterToController[_ingesterAddresses[i]].ingesterIndex;
                uint256 numOfAssignedGroups = _ingesters[controllerAddress][ingesterIndex].assignedGroups.length;
                uint256 numIngestersPerGroup = _groups[groupUsername].ingesterAddresses.length;
                if (numOfAssignedGroups < maxGroupsPerIngester && numIngestersPerGroup < _maxNumberIngesterPerGroup) {
                    //assign group to ingester
                    _ingesters[controllerAddress][ingesterIndex].assignedGroups.push(groupUsername);
                    //update _groups storage to include the new ingester and the respective group index in the ingesters storage
                    _groups[groupUsername].ingesterAddresses.push(_ingesterAddresses[i]);
                    _groups[groupUsername].assignedGroupsIngesterIndex[_ingesterAddresses[i]] = _ingesters[controllerAddress][ingesterIndex].assignedGroups.length - 1;
                    // console.log('group actually added', groupUsername);
                    break;
                }
            }
        }
    }

    /**
    * @notice Retrieves information about a specific group.
    * @param groupUsername The unique identifier (username) of the group to be queried.
    * @return GroupToIngester A struct containing information about the group.
    */
    function getGroup(string memory groupUsername) public view returns (GroupToIngester memory) {
        IIngesterOrchestratorV2.GroupToIngester memory group = IIngesterOrchestratorV2.GroupToIngester(
            _groups[groupUsername].isAdded,
            _groups[groupUsername].ingesterAddresses, 
            _groups[groupUsername].groupUsernameIndex
        );
        return group;
       
    }

    /**
    * @notice Sets the maximum number of ingesters allowed per group.
    * @dev Can only be called by an admin.
    * @param maxNumberIngesterPerGroup The new maximum number of ingesters allowed per group.
    */
    function setMaxNumberIngesterPerGroup(uint256 maxNumberIngesterPerGroup) external onlyAdmin {
        _maxNumberIngesterPerGroup = maxNumberIngesterPerGroup;
    }

   
    /**
    * @notice Removes an ingester from its assigned groups.
    * @dev Used internally when unregistering an ingester.
    * @param groups An array of group names (usernames) the ingester is currently assigned to.
    * @param ingesterAddress The address of the ingester to be removed from the groups.
    */
    function removingIngesterFromGroups(string[] memory groups, address ingesterAddress) internal {
        for (uint256 i = 0; i < groups.length; ++i) {
            // These arrays are capped by the _maxNumberIngesterPerGroup
            for (uint256 j = 0; j < _groups[groups[i]].ingesterAddresses.length; j++) {
                if(_groups[groups[i]].ingesterAddresses[j] == ingesterAddress ) {

                    //delete ingesterAddress from _groups and readjust array length so _maxNumberIngesterPerGroup check remains truthful
                    for (uint256 z = j; z < _groups[groups[i]].ingesterAddresses.length-1; ++z) {
                        _groups[groups[i]].ingesterAddresses[z] = _groups[groups[i]].ingesterAddresses[z+1];
                    }
                    _groups[groups[i]].ingesterAddresses.pop();
                    emit IIngesterOrchestratorV2.IngesterRemovedFromGroup(ingesterAddress, groups[i]);
                    break;
                }
            }
        }
    }

    /**
    * @notice Removes a group from the assigned ingesters.
    * @dev Used when removing a group from the orchestrator. Emits GroupRemovedFromIngester events for each ingester.
    * @param groupUsername The unique identifier (username) of the group to be removed from the ingesters.
    * @param ingesterAddresses An array of addresses of the ingesters assigned to the group.
    */
    function removingGroupFromIngesters(string memory groupUsername, address[] memory ingesterAddresses) public  {
        for (uint256 i = 0; i < ingesterAddresses.length; ++i) {
            address controllerAddress = _registeredIngesterToController[ingesterAddresses[i]].controllerAddress;
            uint256 ingesterIndex = _registeredIngesterToController[ingesterAddresses[i]].ingesterIndex;
            uint256 assignedGroupsIngesterIndex = _groups[groupUsername].assignedGroupsIngesterIndex[ingesterAddresses[i]];

            require(assignedGroupsIngesterIndex < _ingesters[controllerAddress][ingesterIndex].assignedGroups.length, "Index out of bounds");

            string memory groupToMove = _ingesters[controllerAddress][ingesterIndex].assignedGroups[_ingesters[controllerAddress][ingesterIndex].assignedGroups.length - 1];

            _ingesters[controllerAddress][ingesterIndex].assignedGroups[assignedGroupsIngesterIndex] = groupToMove;
            _ingesters[controllerAddress][ingesterIndex].assignedGroups.pop();

            //update move grouped new index to the respective _groups storage
            _groups[groupToMove].assignedGroupsIngesterIndex[ingesterAddresses[i]] = assignedGroupsIngesterIndex;

            emit IIngesterOrchestratorV2.GroupRemovedFromIngester(ingesterAddresses[i], groupUsername);
        }
    }

    /**
    * @notice Unregisters an ingester from the orchestrator.
    * @dev Emits IngesterRemovedFromGroup events for each group the ingester was assigned to.
    * @param ingesterAddress The address of the ingester to be unregistered.
    */
    function unRegisterIngester(address ingesterAddress) external onlyRegistered {
        string[] memory assignedGroups = super.unRegisteringIngester(ingesterAddress, msg.sender);
        removingIngesterFromGroups(assignedGroups, ingesterAddress);
        for (uint256 i = 0; i < assignedGroups.length; ++i) {
            distributeGroup(assignedGroups[i]);
        }
    }
}




