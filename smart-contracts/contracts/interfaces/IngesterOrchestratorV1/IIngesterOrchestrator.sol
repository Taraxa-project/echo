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
    event GroupAdded(string groupUsername);
    event GroupRemoved(string groupUsername);
    event GroupRemovedFromIngester(address indexed ingesterAddress, string group);

    event IngesterRemovedFromGroup(address indexed ingesterAddress, string indexed groupId);
    event IngesterRegisteredGroups(address indexed ingesterAddress, string[] assignedGroups);

    // Functions
    function addGroup(string memory groupUsername) external;
    function removeGroup(string memory groupUsername) external;
    function getGroup(string memory groupUsername) external view returns (GroupToIngester memory);
    function setMaxNumberIngesterPerGroup(uint16 maxNumberIngesterPerGroup) external;
    function unRegisterIngester(address ingesterAddress) external;
    function getIngesterGroups(address ingesterAddress, string[] memory groups) external;
    // function reinitializeGroupsBatch(string[] memory groupUsernames) external;
    // function reinitializeIngestersBatch(address[] memory ingesterAddresses) external;
}

