// SPDX-License-Identifier: MIT
pragma solidity 0.8.14;

interface IIngesterGroupManager {
    
    struct Group{
        bool isAdded;
        uint clusterId;
        address[] ingesterAddresses;
        mapping(address => uint) assignedGroupsIngesterIndex;
        uint groupUsernameIndex;
    }

    struct GroupToIngester{
        bool isAdded;
        uint clusterId;
        address[] ingesterAddresses;
        uint groupUsernameIndex;
    }

    struct Cluster {
        address[] ingesterAddresses;
        string[] clusterGroups;
        uint256 saturationRatio; // groupNames.length / totalCapacity(ingesterAddresses.length * maxGroupsPerIngester)
    }
    
    // Events
    event GroupAdded(string groupUsername);
    event GroupRemoved(string groupUsername);
    event GroupRemovedFromIngester(address indexed ingesterAddress, string group);

    event IngesterRemovedFromGroup(address indexed ingesterAddress, string indexed groupId);
    event IngesterRegisteredGroups(address indexed ingesterAddress, string[] assignedGroups);

    event IngesterDetailsUpdated(address indexed ingesterAddress, bool verified, string[] assignedGroups);
    event SetNewMaxIngesterPerGroup(uint256 maxNumberIngesterPerGroup);

    // Functions
    function getClusters() external returns (uint256[] memory);
    function getCluster(uint256 _id) external returns (uint256);
    function addGroup(string calldata groupUsername) external;
    function removeGroup(string calldata groupUsername) external;
    function getGroup(string calldata groupName) external view returns (GroupToIngester memory);
    function setMaxNumberIngesterPerGroup(uint256 maxNumberIngesterPerGroup) external;
    function updateIngesterProxy(address newIngesterProxy) external;
    function addIngesterToCluster(address _ingesterAddress) external;
    function distributeGroupPostUnregistration(string[] memory _groups) external;
}

