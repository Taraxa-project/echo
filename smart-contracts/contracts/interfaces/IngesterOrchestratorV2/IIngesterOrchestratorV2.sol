// SPDX-License-Identifier: MIT
pragma solidity 0.8.14;

interface IIngesterOrchestratorV2 {
    
    struct GroupToIngesterWithIndex{
        bool isAdded;
        address[] ingesterAddresses;
        mapping(address => uint) assignedGroupsIngesterIndex;
        uint groupUsernameIndex;
    }

    struct GroupToIngester{
        bool isAdded;
        address[] ingesterAddresses;
        uint groupUsernameIndex;
    }

    // Events
    event GroupAdded(string groupUsername);
    event GroupRemoved(string groupUsername);
    event GroupRemovedFromIngester(address indexed ingesterAddress, string group);

    event IngesterRemovedFromGroup(address indexed ingesterAddress, string indexed groupId);
    event IngesterRegisteredGroups(address indexed ingesterAddress, string[] assignedGroups);

    event SetNewMaxIngesterPerGroup(uint256 maxNumberIngesterPerGroup);

    // Functions
    function addGroup(string memory groupUsername) external;
    function removeGroup(string memory groupUsername) external;
    function getGroup(string memory groupUsername) external view returns (GroupToIngester memory);
    function setMaxNumberIngesterPerGroup(uint256 maxNumberIngesterPerGroup) external;
    function unRegisterIngester(address ingesterAddress) external;
}

