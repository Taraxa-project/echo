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
        // uint256 clusterGroupCount;
        // uint256 saturationRatio; // groupNames.length / totalCapacity(ingesterAddresses.length * maxGroupsPerIngester)
        uint256 clusterRemainingCapacity;
        // mapping(address => string[]);
    }
    
    // Events
    event GroupAdded(string groupUsername);
    event GroupRemoved(string groupUsername);
    event GroupRemovedFromIngester(address indexed ingesterAddress, string group);
    event IngesterRemovedFromGroup(address indexed ingesterAddress, string indexed groupId);
    event IngesterRegisteredGroups(address indexed ingesterAddress, string[] assignedGroups);
    event IngesterDetailsUpdated(address indexed ingesterAddress, bool verified, string[] assignedGroups);
    event SetNewMaxIngesterPerGroup(uint256 maxNumberIngesterPerGroup);
    event IngesterAddedToCluster(address indexed ingesterAddress, uint256 indexed clusterId);

    // Functions
    function getClusters() external view returns (uint256[] memory);
    function getCluster(uint256 _id) external view returns (Cluster memory);
    function addGroup(string calldata groupUsername) external;
    function removeGroup(string calldata groupUsername) external;
    function getGroup(string calldata groupName) external view returns (GroupToIngester memory);
    function getGroupUsernameByIndex(uint256 groupIndex) external view returns (string memory);
    function getGroupCount() external view returns (uint256);
    function updateIngesterProxy(address newIngesterProxy) external;
    function addIngesterToCluster(address _ingesterAddress) external returns(uint256);
    function removeIngesterFromGroups(string[] memory _groups, address _ingesterAddress) external;
    function distributeGroupPostUnregistration(string[] memory _groups) external;
    function setIngesterProxy(address _ingesterProxyAddress) external;

    function getMaxClusterSize() external view returns (uint256);
    function getMaxGroupsPerIngester() external view returns (uint256);
    function getMaxNumberIngesterPerGroup() external view returns (uint256);
    function setMaxClusterSize(uint256 _maxClusterSize) external;
    function setMaxGroupsPerIngester(uint256 _maxGroupsPerIngester) external;
    function setMaxNumberIngesterPerGroup(uint256 _maxNumberIngesterPerGroup) external;
}

