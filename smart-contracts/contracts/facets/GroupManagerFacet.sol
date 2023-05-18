// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { LibAppStorage, AppStorage } from  "../libraries/LibAppStorage.sol";
import "../interfaces/IIngesterGroupManager.sol";
import "./AccessControlFacet.sol";
import "./CommonFunctionsFacet.sol";

contract GroupManagerFacet is AccessControlFacet, CommonFunctionsFacet, IIngesterGroupManager {

   /**
    * @notice Adds a new group to the system and distributes it among the clusters.
    * @param groupUsername The username of the group to be added.
   */
   function addGroup(string calldata groupUsername) external onlyAdmin {
        require(bytes(groupUsername).length != 0, "GroupUsername is empty");
        require(!s.groups[groupUsername].isAdded, "Group already exists.");
        s.groupUsernames.push(groupUsername);
        s.groups[groupUsername].isAdded = true;
        s.groups[groupUsername].groupUsernameIndex = s.groupUsernames.length -1;
        ++s.groupCount;
        uint256 clusterId = addGroupToCluster(groupUsername);
        checkUnallocatedIngesters(clusterId);
        balanceIngesters(clusterId);
        emit IIngesterGroupManager.GroupAdded(groupUsername);
    }

    /**
    * @dev Adds a new cluster to the system and assigns it an ID.
    * @return uint256 The ID assigned to the new cluster.
    */
    function addNewCluster() internal returns (uint256) {
        uint256 clusterId = s.clusterIds.length;
        s.clusterIds.push(clusterId);
        s.groupsCluster[clusterId].isActive = true;
        emit ClusterAdded(clusterId);
        return clusterId;
    }

    /**
    * @dev Checks for unallocated ingesters and assigns them to a specified cluster if possible.
    * @param clusterId The ID of the cluster to assign unallocated ingesters to.
    */
    function checkUnallocatedIngesters(uint256 clusterId) internal {
        //if newly unavailable ingesters, attempt to assign any unregistered ingester
        if (s.unAllocatedIngesters.length > 0 && s.groupsCluster[clusterId].ingesterAddresses.length < s.maxIngestersPerGroup) {
            address unAllocatedIngester = s.unAllocatedIngesters[s.unAllocatedIngesters.length - 1];
            LibAppStorage.addIngesterToClusterId(unAllocatedIngester, clusterId);
        }
    }

    /**
    * @dev Attempts to balance the distribution of ingesters among clusters.
    * @param clusterId The ID of the cluster to balance ingesters for.
    */
    function balanceIngesters(uint256 clusterId) internal {
        //if there replication and cluster is currently empty, allocatiion from other clusters should be done
        if (s.groupsCluster[clusterId].ingesterAddresses.length == 0 && s.maxIngestersPerGroup > 1) {
            (uint clusterIdAvailable, bool foundAvailableCluster) = LibAppStorage.getClusterWithIngesterReplication();
            //if available cluster, then steal ingester from available cluster and put it into empty cluster
            if (foundAvailableCluster) {
                LibAppStorage.fetchIngesterFromAvailableCluster(clusterIdAvailable, clusterId);
            } 
        }
    }

    /**
    * @dev Adds a new group to a cluster.
    * @param groupUsername The username of the group to add.
    * @return uint256 The ID of the cluster the group was added to.
    */
    function addGroupToCluster(string calldata groupUsername) internal returns(uint256){
        uint256 clusterId = 0;
        bool foundAvailableCluster = false;
        if (s.clusterIds.length == 0) {
            clusterId = addNewCluster();
        } else {
            (clusterId, foundAvailableCluster) = getAvailableClusterForGroups();
            if (!foundAvailableCluster) {
                clusterId = addNewCluster();
            }
        }

        s.groupsCluster[clusterId].groupUsernames.push(groupUsername);
        ++s.groupsCluster[clusterId].groupCount;
        s.groups[groupUsername].groupUsernameClusterIndex = s.groupsCluster[clusterId].groupUsernames.length - 1;
        s.groups[groupUsername].clusterId = clusterId;
        
        emit GroupAddedToCluster(groupUsername, clusterId);
        
        return clusterId;
    }

    /**
    * @dev Checks for available clusters and returns one if found.
    * @return uint256 The ID of the available cluster.
    * @return bool A boolean value indicating if an available cluster was found.
    */
    function getAvailableClusterForGroups() internal returns(uint256, bool) {
        uint256 availableClusterId = 0;
        bool foundAvailableCluster = false;

        //prioritize inactive cluster to add groups to 
        if (s.inActiveClusters.length > 0) {
            availableClusterId = s.inActiveClusters[s.inActiveClusters.length - 1];
            s.inActiveClusters.pop();
            s.groupsCluster[availableClusterId].isActive = true;
            foundAvailableCluster = true;
            emit ActivateInactiveCluster(availableClusterId);
        }
        else {
            for (uint256 i = 0; i < s.clusterIds.length; i++) {
                if (s.groupsCluster[s.clusterIds[i]].groupCount < s.maxClusterSize) {
                    availableClusterId = s.clusterIds[i];
                    foundAvailableCluster = true;
                    break;
                }
            }
            
        }

        return (availableClusterId, foundAvailableCluster);
    }

    /**
    * @dev Removes a group from the storage.
    * @param groupUsername The username of the group to remove.
    */
    function removeGroupFromStorage(string memory groupUsername) internal {
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
    }

    /**
    * @notice Removes a group from the system.
    * @param groupUsername The username of the group to be removed.
    */
    function removeGroup(string memory groupUsername) external onlyAdmin {
        require(bytes(groupUsername).length != 0, "GroupUsername is empty");
        require(s.groups[groupUsername].isAdded, "Group does not exist.");

        removeGroupFromCluster(s.groups[groupUsername].clusterId, groupUsername);
        removeGroupFromStorage(groupUsername);

        --s.groupCount;

        emit IIngesterGroupManager.GroupRemoved(groupUsername);
    }

    /**
    * @notice Removes a group from the system by its index.
    * @param groupIndex The index of the group to be removed.
    */
    function removeGroupByIndex(uint256 groupIndex) external onlyAdmin {
        require(groupIndex < s.groupUsernames.length, "Group index exceed the list length");
        string memory groupUsername = s.groupUsernames[groupIndex];
        require(s.groups[groupUsername].isAdded, "Group does not exist.");

        removeGroupFromCluster(s.groups[groupUsername].clusterId, groupUsername);
        removeGroupFromStorage(groupUsername);

        --s.groupCount;

        emit IIngesterGroupManager.GroupRemoved(groupUsername);
    }


    /**
    * @dev Removes a group from a specified cluster.
    * @param clusterId The ID of the cluster to remove the group from.
    * @param groupUsername The username of the group to remove.
    */
    function removeGroupFromCluster(uint256 clusterId, string memory groupUsername) internal {
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
            emit InactivateCluster(clusterId);
        }

        //TODO: may need to re-adjust the ingesters assigned to this cluster and assign them to a non-empty cluster
        emit IIngesterGroupManager.GroupRemovedFromCluster(clusterId, groupUsername);
    }

    /**
    * @dev Moves ingesters from an inactive cluster to available clusters.
    * @param ingesterAddresses The addresses of the ingesters to move.
    */
    function moveIngestersToAvailableClusters(address[] storage ingesterAddresses) internal {
        for (uint256 i = 0; i < ingesterAddresses.length; i++) {
            address ingesterAddress = ingesterAddresses[i];
            address controllerAddress = s.ingesterToController[ingesterAddress].controllerAddress;
            LibAppStorage.addIngesterToCluster(ingesterAddress, controllerAddress);
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
    * @notice Sets the maximum cluster size.
    * @param maxClusterSize The new maximum number of ingesters allowed in a cluster.
    */
    function setMaxClusterSize(uint256 maxClusterSize) external onlyAdmin {
        s.maxClusterSize = maxClusterSize;
        emit IIngesterGroupManager.MaxClusterSizeUpdated(maxClusterSize);
    }

    /**
    * @notice Retrieves the maximum number of ingesters allowed per group.
    * @return uint256 The maximum number of ingesters per group.
    */
    function getMaxIngestersPerGroup() external view returns (uint256) {
        return s.maxIngestersPerGroup;
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
