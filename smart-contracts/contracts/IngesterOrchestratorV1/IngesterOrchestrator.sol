// SPDX-License-Identifier: MIT
pragma solidity 0.8.14;


import "../interfaces/IngesterOrchestratorV1/IIngesterOrchestrator.sol";
import "./IngesterRegistration.sol";
import "./IngesterRegistryAccessControl.sol";
import "./IngesterDataGathering.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract IngesterOrchestrator is IngesterRegistryAccessControl, IngesterRegistration , IngesterDataGathering, IIngesterOrchestrator {

    constructor(uint16 maxNumberIngesterPerGroup) IngesterRegistryAccessControl(){
        _maxNumberIngesterPerGroup = maxNumberIngesterPerGroup;
    }

    mapping(string => IIngesterOrchestrator.GroupToIngesterWithIndex) private _groups;

    uint16 public _maxNumberIngesterPerGroup; // 1
    uint public _groupCount;

    /**
    * @notice Adds a new group to the orchestrator.
    * @dev Emits a GroupAdded event upon successful addition of the group.
    * @param groupUsername The unique identifier (username) of the group to be added.
    */
    function addGroup(string memory groupUsername) public onlyAdmin {
        require(!_groups[groupUsername].isAdded, "Group already exists.");
        IIngesterOrchestrator.GroupToIngesterWithIndex storage _defaultGroupToIngesterWithIndex = _groups[groupUsername];
        _defaultGroupToIngesterWithIndex.isAdded = true;
        ++_groupCount;
        emit IIngesterOrchestrator.GroupAdded(groupUsername);
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
        --_groupCount;
        emit IIngesterOrchestrator.GroupRemoved(groupUsername);
    }

    /**
    * @notice Retrieves information about a specific group.
    * @param groupUsername The unique identifier (username) of the group to be queried.
    * @return GroupToIngester A struct containing information about the group.
    */
    function getGroup(string memory groupUsername) public view returns (GroupToIngester memory) {
        IIngesterOrchestrator.GroupToIngester memory group = IIngesterOrchestrator.GroupToIngester(_groups[groupUsername].isAdded, _groups[groupUsername].ingesterAddresses);
        return group;
    }

    /**
    * @notice Sets the maximum number of ingesters allowed per group.
    * @dev Can only be called by an admin.
    * @param maxNumberIngesterPerGroup The new maximum number of ingesters allowed per group.
    */
    function setMaxNumberIngesterPerGroup(uint16 maxNumberIngesterPerGroup) external onlyAdmin {
        _maxNumberIngesterPerGroup = maxNumberIngesterPerGroup;
    }

    /**
    * @notice Removes an ingester from its assigned groups.
    * @dev Used internally when unregistering an ingester.
    * @param groups An array of group names (usernames) the ingester is currently assigned to.
    * @param ingesterAddress The address of the ingester to be removed from the groups.
    */
    function removingIngesterFromGroups(string[] memory groups, address ingesterAddress) public  {
        for (uint i = 0; i < groups.length; i++) {
            // These arrays are capped by the _maxNumberIngesterPerGroup
            for (uint j = 0; j < _groups[groups[i]].ingesterAddresses.length; j++) {
                if(_groups[groups[i]].ingesterAddresses[j] == ingesterAddress ) {
                    //delete ingesterAddress from _groups and readjust array length so _maxNumberIngesterPerGroup check remains truthful
                    for (uint z = j; z < _groups[groups[i]].ingesterAddresses.length-1; z++) {
                        _groups[groups[i]].ingesterAddresses[z] = _groups[groups[i]].ingesterAddresses[z+1];
                    }
                    _groups[groups[i]].ingesterAddresses.pop();
                    emit IIngesterOrchestrator.IngesterRemovedFromGroup(ingesterAddress, groups[i]);
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
        for (uint i = 0; i < ingesterAddresses.length; i++) {
            address controllerAddress = _registeredIngesterToController[ingesterAddresses[i]].controllerAddress;
            uint ingesterIndex = _registeredIngesterToController[ingesterAddresses[i]].ingesterIndex;
            uint assignedGroupsIngesterIndex = _groups[groupUsername].assignedGroupsIngesterIndex[ingesterAddresses[i]];

            delete _ingesters[controllerAddress][ingesterIndex].assignedGroups[assignedGroupsIngesterIndex];
            emit IIngesterOrchestrator.GroupRemovedFromIngester(ingesterAddresses[i], groupUsername);
        }
    }

    // function reinitializeGroupsBatch(string[] memory groupUsernames) external {
    //     for (uint256 i = 0; i < groupUsernames.length; i++) {
    //         string memory groupUsername = groupUsernames[i];
    //         reinitializeAssignedGroupsIngesterIndex(groupUsername);
    //         _groups[groupUsername].isAdded = true;
    //         _groups[groupUsername].ingesterAddresses = new address[](0);
    //     }
    // }

    // function reinitializeIngestersBatch(address[] memory ingesterAddresses) external {
    //     for (uint256 i = 0; i < ingesterAddresses.length; i++) {
    //         address controllerAddress = _registeredIngesterToController[ingesterAddresses[i]].controllerAddress;
    //         uint ingesterIndex = _registeredIngesterToController[ingesterAddresses[i]].ingesterIndex;
    //         _ingesters[controllerAddress][ingesterIndex].assignedGroups = new string[](0);
    //     }
    // }

    // function reinitializeAssignedGroupsIngesterIndex(string memory groupUsername) internal {
    //     for (uint256 i = 0; i < _groups[groupUsername].ingesterAddresses.length; i++) {
    //         address ingesterAddress = _groups[groupUsername].ingesterAddresses[i];
    //         delete _groups[groupUsername].assignedGroupsIngesterIndex[ingesterAddress];
    //     }
    // }

    //TODO: Modify this function to continually adjust the assignedGroups of ingesters
    // Goal of having each group being monitored by 3 different ingester. This would require a much more complex impl
    function getIngesterGroups(address ingesterAddress, string[] memory groups) external onlyRegistered {
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
            }
        }

        emit IIngesterOrchestrator.IngesterRegisteredGroups(ingesterAddress, _ingesters[msg.sender][ingesterIndex].assignedGroups);
    }

    /**
    * @notice Unregisters an ingester from the orchestrator.
    * @dev Emits IngesterRemovedFromGroup events for each group the ingester was assigned to.
    * @param ingesterAddress The address of the ingester to be unregistered.
    */
    function unRegisterIngester(address ingesterAddress) external onlyRegistered {
        string[] memory assignedGroups = super.unRegisteringIngester(ingesterAddress, msg.sender);
        removingIngesterFromGroups(assignedGroups, ingesterAddress);
    }
}




