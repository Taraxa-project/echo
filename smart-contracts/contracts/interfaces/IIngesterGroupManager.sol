// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IIngesterGroupManager {

    struct Group {
        bool isAdded;
        uint256 clusterId;
        uint256 groupUsernameIndex;
        uint256 groupUsernameClusterIndex;
    }

    struct GroupWithIngesters {
        bool isAdded;
        uint256 clusterId;
        uint256 groupUsernameIndex;
        uint256 groupUsernameClusterIndex;
        address[] ingesterAddresses;
    }

    struct GroupsCluster {
        bool isActive;
        string[] groupUsernames;
        address[] ingesterAddresses;
        uint256 groupCount;
        uint256 clusterIndex;
    }

    // Events
    event GroupAdded(string groupUsername);
    event GroupRemoved(string groupUsername);
    event GroupRemovedFromIngester(address indexed ingesterAddress, string group);
    event GroupRemovedFromCluster(uint256 indexed _clusterId, string indexed _groupUsername);
    event MaxIngesterPerGroupUpdated(uint256 maxNumberIngesterPerGroup);
    event MaxClusterSizeUpdated(uint256 maxClusterSize);
    event GroupAddedToCluster(string groupUsername, uint256 indexed clusterId);
    event IngesterAddedToCluster(address indexed ingesterAddress, uint256 indexed clusterId);
    event ActivateInactiveCluster(uint256 indexed clusterId);
    event InactivateCluster(uint256 indexed clusterId);
    event UnAllocatedIngesterAdded(address indexed ingesterAddress);
    event ClusterAdded(uint256 indexed clusterId);


    // Functions
    function addGroup(string calldata groupUsername) external;
    function removeGroup(string calldata groupUsername) external;
    function getGroup(string calldata groupName) external view returns (GroupWithIngesters memory);
    function setMaxClusterSize(uint256 maxClusterSize) external;
    function setMaxIngestersPerGroup(uint256 maxIngestersPerGroup) external;
}

