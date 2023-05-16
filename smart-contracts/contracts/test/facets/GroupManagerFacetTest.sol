// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { LibAppStorageTest, AppStorageTest } from  "../libraries/LibAppStorageUpgradeTest.sol";
import "../../interfaces/IIngesterGroupManager.sol";
import "./AccessControlFacetTest.sol";
import "./CommonFunctionsFacetTest.sol";

contract GroupManagerFacetTest is AccessControlFacetTest, CommonFunctionsFacetTest, IIngesterGroupManager {

   /**
    * @notice Adds a new group to the system and distributes it among the clusters.
    * @param groupUsername The username of the group to be added.
   */
   function addGroup(string calldata groupUsername) external onlyAdmin {
        require(!s.groups[groupUsername].isAdded, "Group already exists.");
        s.groupUsernames.push(groupUsername);
        s.groups[groupUsername].isAdded = true;
        s.groups[groupUsername].groupUsernameIndex = s.groupUsernames.length -1;
        ++s.groupCount;
        addGroupToCluster(groupUsername);
        emit IIngesterGroupManager.GroupAdded(groupUsername);
    }

    function addGroupToCluster(string calldata groupUsername) internal {
        uint256 clusterId = 0;
        if (s.clusterIds.length == 0) {
            s.clusterIds.push(clusterId);
            s.groupsCluster[clusterId].isActive = true;
        } else {
            clusterId = getAvailableCluster();
        }

        s.groupsCluster[clusterId].groupUsernames.push(groupUsername);
        ++s.groupsCluster[clusterId].groupCount;
        s.groups[groupUsername].groupUsernameClusterIndex = s.groupsCluster[clusterId].groupUsernames.length - 1;
        s.groups[groupUsername].clusterId = clusterId;
        
        emit GroupAddedToCluster(groupUsername, clusterId);
    }

    function getAvailableCluster() internal returns(uint256) {
        uint256 availableGroups = 0;
        uint256 availableClusterId = 0;

        //prioritize inactive cluster to add groups to 
        if (s.inActiveClusters.length > 0) {
            availableClusterId = s.inActiveClusters[s.inActiveClusters.length - 1];
            s.inActiveClusters.pop();
            s.groupsCluster[availableClusterId].isActive = true;
        }
        else {
            for (uint256 i = 0; i < s.clusterIds.length; i++) {
                if (s.groupsCluster[s.clusterIds[i]].groupCount < s.maxClusterSize) {
                    availableClusterId = s.clusterIds[i];
                }
            }
        }

        return availableClusterId;
    }

    /**
    * @notice Removes a group from the system.
    * @param groupUsername The username of the group to be removed.
    */
    function removeGroup(string calldata groupUsername) external onlyAdmin {
        require(s.groups[groupUsername].isAdded, "Group does not exist.");

        removeGroupFromCluster(s.groups[groupUsername].clusterId, groupUsername);

        //Remove group from groupUsernames
        uint256 groupUsernameIndex = s.groups[groupUsername].groupUsernameIndex;
        uint256 amountOfGroups = s.groupUsernames.length;
        if (s.groups[groupUsername].groupUsernameIndex != amountOfGroups - 1) {
            string memory groupToMove = s.groupUsernames[amountOfGroups - 1];
            s.groupUsernames[groupUsernameIndex] = groupToMove;
            s.groups[groupToMove].groupUsernameIndex = groupUsernameIndex;
        }
        s.groupUsernames.pop();

        delete s.groups[groupUsername];

        --s.groupCount;

        emit IIngesterGroupManager.GroupRemoved(groupUsername);
    }


    /**
     * @dev Removes a group from the specified cluster and its associated ingester addresses.
     * @param clusterId The cluster ID to remove the group from.
     * @param groupUsername The group username to remove.
    */
    function removeGroupFromCluster(uint256 clusterId, string calldata groupUsername) internal {
        uint256 groupUsernameClusterIndex = s.groups[groupUsername].groupUsernameClusterIndex;
        uint256 numGroups = s.groupsCluster[clusterId].groupUsernames.length;
        if (groupUsernameClusterIndex != numGroups - 1) {
            string memory groupToMove = s.groupsCluster[clusterId].groupUsernames[numGroups - 1];
            s.groupsCluster[clusterId].groupUsernames[groupUsernameClusterIndex] = groupToMove;
            s.groups[groupToMove].groupUsernameClusterIndex = groupUsernameClusterIndex;
        }
        s.groupsCluster[clusterId].groupUsernames.pop();
        --s.groupsCluster[clusterId].groupCount;
        
        if (s.groupsCluster[clusterId].groupCount == 0) {
            s.groupsCluster[clusterId].isActive = false;
            s.inActiveClusters.push(clusterId);
            moveIngestersToAvailableClusters(s.groupsCluster[clusterId].ingesterAddresses);
            s.groupsCluster[clusterId].ingesterAddresses = new address[](0);
        }

        //TODO: may need to re-adjust the ingesters assigned to this cluster and assign them to a non-empty cluster
        emit IIngesterGroupManager.GroupRemovedFromCluster(clusterId, groupUsername);
    }

    function moveIngestersToAvailableClusters(address[] storage ingesterAddresses) internal {
        for (uint256 i = 0; i < ingesterAddresses.length; i++) {
            address ingesterAddress = ingesterAddresses[i];
            address controllerAddress = s.ingesterToController[ingesterAddress].controllerAddress;
            LibAppStorageTest.addIngesterToCluster(ingesterAddress, controllerAddress);
        }
    }

     /**
    * @notice Retrieves the details of a group by its username.
    * @param groupUsername The username of the group to retrieve.
    * @return GroupWithIngesters struct containing the group's details and the associated ingesters.
    */
    function getGroup(string calldata groupUsername) external view returns (IIngesterGroupManager.GroupWithIngesters memory) {
        IIngesterGroupManager.Group memory group = s.groups[groupUsername];
        IIngesterGroupManager.GroupWithIngesters memory groups = GroupWithIngesters(
            group.isAdded,
            group.clusterId,
            group.groupUsernameIndex,
            group.groupUsernameClusterIndex,
            s.groupsCluster[group.clusterId].ingesterAddresses
        );
        return groups;
    }

    /**
    * @notice Retrieves the maximum cluster size.
    * @return uint256 The maximum number of ingesters allowed in a cluster.
    */
    function getMaxClusterSize() external view returns (uint256) {
        return s.maxClusterSize;
    }

    /**
    * @notice Retrieves the maximum number of ingesters allowed per group.
    * @return uint256 The maximum number of ingesters per group.
    */
    function getMaxIngestersPerGroup() external view returns (uint256) {
        return s.maxIngestersPerGroup;
    }

    /**
    * @notice Sets the maximum cluster size.
    * @param maxClusterSize The new maximum number of ingesters allowed in a cluster.
    */
    function setMaxClusterSize(uint256 maxClusterSize) external onlyAdmin {
        s.maxClusterSize = maxClusterSize;
        emit IIngesterGroupManager.MaxClusterSizeUpdated(maxClusterSize);
    }

    /**
    * @notice Sets the maximum number of ingesters allowed per group.
    * @param maxIngestersPerGroup The new maximum number of ingesters per group.
    */
    function setMaxIngestersPerGroup(uint256 maxIngestersPerGroup) external  {
        require(maxIngestersPerGroup >= 1, "Can only set max ingester per group >= 1");
        s.maxIngestersPerGroup = maxIngestersPerGroup;
        emit IIngesterGroupManager.MaxIngesterPerGroupUpdated(maxIngestersPerGroup);
    }

    /**
    * @notice Retrieves the group username by its index.
    * @param groupIndex The index of the group in the groups list.
    * @return string The groupUsername of the group corresponding to the provided index.
    */
    function getGroupUsernameByIndex(uint256 groupIndex) external view returns (string memory) {
        return s.groupUsernames[groupIndex];
    }
}
