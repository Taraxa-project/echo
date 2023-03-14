// SPDX-License-Identifier: MIT
pragma solidity 0.8.14;


import "./interfaces/IIngesterOrchestrator.sol";
import "./IngesterRegistration.sol";
import "./IngesterRegistryAccessControl.sol";
import "./IngesterDataGathering.sol";


contract IngesterOrchestrator is IngesterRegistryAccessControl, IngesterRegistration , IngesterDataGathering, IIngesterOrchestrator {

    constructor(uint16 maxNumberIngesterPerGroup) IngesterRegistryAccessControl(){
        _maxNumberIngesterPerGroup = maxNumberIngesterPerGroup;
    }

    mapping(uint => IIngesterOrchestrator.GroupToIngesterWithIndex) private _groups;
    

    uint16 public _maxNumberIngesterPerGroup;
    uint public _groupCount;

    function addGroup(uint groupId) public onlyAdmin {
        require(!_groups[groupId].isAdded, "Group already exists.");
        IIngesterOrchestrator.GroupToIngesterWithIndex storage _defaultGroupToIngesterWithIndex = _groups[groupId];
        _defaultGroupToIngesterWithIndex.isAdded = true;
        _groupCount++;
        emit IIngesterOrchestrator.GroupAdded(groupId);
    }

    function removeGroup(uint groupId) public onlyAdmin {
        require(_groups[groupId].isAdded, "Group does not exist.");
        address[] memory ingesterAddresses = _groups[groupId].ingesterAddresses;
        removingGroupFromIngesters(groupId, ingesterAddresses); //gas intensive
        _groups[groupId].isAdded = false;
        _groupCount--;
        emit IIngesterOrchestrator.GroupRemoved(groupId);
    }

    function getGroup(uint groupId) public view returns (GroupToIngester memory) {
        IIngesterOrchestrator.GroupToIngester memory group = IIngesterOrchestrator.GroupToIngester(_groups[groupId].isAdded, _groups[groupId].ingesterAddresses);
        return group;
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
                    emit IIngesterOrchestrator.IngesterRemovedFromGroup(ingesterAddress, groups[i]);
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
            emit IIngesterOrchestrator.GroupRemovedFromIngester(ingesterAddresses[i], groupId);
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

        emit IIngesterOrchestrator.IngesterRegisteredGroups(ingesterAddress, _ingesters[msg.sender][ingesterIndex].assignedGroups);
    }

    function unRegisterIngester(address ingesterAddress) external onlyRegistered {
        uint256[] memory assignedGroups = super.unRegisteringIngester(ingesterAddress, msg.sender);
        removingIngesterFromGroups(assignedGroups, ingesterAddress);
    }

}




