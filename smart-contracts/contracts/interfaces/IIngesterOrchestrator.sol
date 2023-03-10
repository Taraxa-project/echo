// SPDX-License-Identifier: MIT
pragma solidity 0.8.14;

interface IIngesterOrchestrator {
    
    struct GroupToIngesterWithIndex{
        bool isAdded;
        address[] ingesterAddresses;
        mapping(address => uint) assignedGroupsIngesterIndex;
    }

    struct GroupToIngester{
        bool isAdded;
        address[] ingesterAddresses;
    }

    // Events
    event GroupAdded(uint groupUsername);
    event GroupRemoved(uint groupUsername);
    event GroupRemovedFromIngester(address indexed ingesterAddress, uint group);

    event IngesterRemovedFromGroup(address indexed ingesterAddress, uint indexed groupId);
    event IngesterRegisteredGroups(address indexed ingesterAddress, uint[] assignedGroups);

    // Functions
    // function transferContractOwnership(address newOwner) external;
    function addGroup(uint groupId) external;
    function removeGroup(uint groupId) external;
    function getGroup(uint groupId) external view returns (GroupToIngester memory);
    function setMaxNumberIngesterPerGroup(uint16 maxNumberIngesterPerGroup) external;
    function unRegisterIngester(address ingesterAddress) external;
    function getIngesterGroups(address ingesterAddress, uint[] memory groups) external;
    
    // function removingIngesterFromGroups(uint[] memory groups, address ingesterAddress) public;
    // function removingGroupFromIngesters(uint groupId, address[] memory ingesterAddresses) external;
   
}

