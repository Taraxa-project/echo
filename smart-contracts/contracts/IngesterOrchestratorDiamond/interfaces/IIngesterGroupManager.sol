// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IIngesterGroupManager {
    
    struct Group{
        bool isAdded;
        uint256 clusterId;
        address[] ingesterAddresses;
        mapping(address => IngesterToGroup) ingesterToGroup;
        uint256 groupUsernameIndex;
    }

    struct IngesterToGroup{
        bool isAdded;
        uint256 groupClusterIngesterIndex;
    }

    struct GroupSlim{
        bool isAdded;
        uint256 clusterId;
        address[] ingesterAddresses;
        uint256 groupUsernameIndex;
    }

    struct Cluster {
        address[] ingesterAddresses;
        uint256 clusterGroupCount;
        uint256 clusterRemainingCapacity;
        uint256 clusterIndex;
        mapping(address => string[]) ingesterToAssignedGroups; 
    }

    struct ClusterSlim {
        address[] ingesterAddresses;
        uint256 clusterGroupCount;
        uint256 clusterRemainingCapacity;
    }

    // Events
    event GroupDistributed(uint256 clusterId, string groupUsername, address ingesterAddress);
    event GroupAdded(string groupUsername);
    event GroupRemoved(string groupUsername);
    event GroupRemovedFromIngester(address indexed ingesterAddress, string group);
    event GroupRemovedFromCluster(uint256 indexed _clusterId, string indexed _groupUsername);
    event IngesterRemovedFromGroup(address indexed ingesterAddress, string indexed groupId);
    event IngesterRegisteredGroups(address indexed ingesterAddress, string[] assignedGroups);
    event UnAllocatedGroupsAdded(string[] groups);
    // event IngesterDetailsUpdated(address indexed ingesterAddress, bool verified, string[] assignedGroups);
    // event MaxIngesterPerGroupUpdated(uint256 maxNumberIngesterPerGroup);
    // event IngesterAddedToCluster(address indexed ingesterAddress, uint256 indexed clusterId);
    // event RemoveUnallocatedGroup(string unAllocatedGroup);
    // event IngesterProxyAddressUpdated(address indexed newIngesterProxy);
    // event MaxClusterSizeUpdated(uint256 maxClusterSize);
    // event MaxGroupsPerIngesterUpdated(uint256 maxGroupsPerIngester);


    // Functions
    // function getClusters() external view returns (uint256[] memory);
    // function getCluster(uint256 _id) external view returns (ClusterSlim memory);
    function addGroup(string calldata groupUsername) external;
    function removeGroup(string calldata groupUsername) external;
    function getGroup(string calldata groupName) external view returns (GroupSlim memory);

}

