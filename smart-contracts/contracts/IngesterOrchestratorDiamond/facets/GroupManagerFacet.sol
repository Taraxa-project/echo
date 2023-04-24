// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { LibAppStorage, AppStorage } from  "../libraries/LibAppStorage.sol";
import "../interfaces/IIngesterGroupManager.sol";
import "./AccessControlFacet.sol";


contract GroupManagerFacet is AccessControlFacet, IIngesterGroupManager {

   function addGroup(string calldata groupUsername) external onlyAdmin {
        require(!s.groups[groupUsername].isAdded, "Group already exists.");
        s.groupUsernames.push(groupUsername);
        s.groups[groupUsername].isAdded = true;
        s.groups[groupUsername].groupUsernameIndex = s.groupUsernames.length -1;
        ++s.groupCount;
        distributeGroup(groupUsername);
        emit IIngesterGroupManager.GroupAdded(groupUsername);
    }

    function distributeGroup(string memory groupUsername) internal {
        uint clusterId = getMostCapacityCluster();
        require(s.ingesterClusters[clusterId].clusterRemainingCapacity > 0, 'No more ingesters available to add groups to');

        uint256 numIngesters = s.ingesterClusters[clusterId].ingesterAddresses.length;

        if (numIngesters == 1) {
            distributeGroupToIngester(groupUsername, clusterId, s.ingesterClusters[clusterId].ingesterAddresses[0]);
        } else {
            uint256 maxGroupsPerIngester = 1;
            uint256 numClusterGroups = s.ingesterClusters[clusterId].clusterGroupCount;

            //formula to apply a balanced distribution of groups across the ingesters
            if (numClusterGroups > 0) {
                maxGroupsPerIngester = ceilDiv((numClusterGroups + numIngesters - 1), numIngesters);
            }

            for (uint256 i = 0; i < numIngesters; ++i) {
                address currentIngesterAddress = s.ingesterClusters[clusterId].ingesterAddresses[i];
                if(s.groups[groupUsername].ingesterToGroup[currentIngesterAddress].isAdded) {
                    continue;
                }

                uint256 numOfAssignedGroups = s.ingesterClusters[clusterId].ingesterToAssignedGroups[currentIngesterAddress].length;
                uint256 numIngestersPerGroup = s.groups[groupUsername].ingesterAddresses.length;

                if (numOfAssignedGroups < maxGroupsPerIngester && numIngestersPerGroup < s.maxIngestersPerGroup) {
                    //assign ingester to group storage
                    s.groups[groupUsername].ingesterAddresses.push(currentIngesterAddress);
                    //add group to cluster for the respective ingester
                    s.ingesterClusters[clusterId].ingesterToAssignedGroups[currentIngesterAddress].push(groupUsername);
                    //keep track of where it is stored so it is easy to remove
                    s.groups[groupUsername].ingesterToGroup[currentIngesterAddress] = IngesterToGroup(true, s.ingesterClusters[clusterId].ingesterToAssignedGroups[currentIngesterAddress].length - 1);
                    ++s.ingesterClusters[clusterId].clusterGroupCount;

                    // Re-calculate clusterRemainingCapacity
                    require((s.maxGroupsPerIngester * s.ingesterClusters[clusterId].ingesterAddresses.length) >= s.ingesterClusters[clusterId].clusterGroupCount, "More groups in cluster than cluster constraints");
                    s.ingesterClusters[clusterId].clusterRemainingCapacity = (s.maxGroupsPerIngester * s.ingesterClusters[clusterId].ingesterAddresses.length) - s.ingesterClusters[clusterId].clusterGroupCount;

                    emit IIngesterGroupManager.GroupDistributed(clusterId, groupUsername, currentIngesterAddress);
                    //if there is replication, then keep assigning to the remining cluster, otherwise break
                    if ( i >= s.maxIngestersPerGroup - 1) {
                        break;
                    }
                }
            }
        }
    }

    function distributeGroupToIngester(string memory groupUsername, uint256 clusterId, address ingesterAddress) internal {

        uint256 numOfAssignedGroups = s.ingesterClusters[clusterId].ingesterToAssignedGroups[ingesterAddress].length;
        uint256 numIngestersPerGroup = s.groups[groupUsername].ingesterAddresses.length;

        if (numOfAssignedGroups <= s.maxGroupsPerIngester && numIngestersPerGroup < s.maxIngestersPerGroup) {
            //assign ingester to group storage            
            s.groups[groupUsername].ingesterAddresses.push(ingesterAddress);
            //add group to cluster for the respective ingester
            s.ingesterClusters[clusterId].ingesterToAssignedGroups[ingesterAddress].push(groupUsername);
            //keep track of where it is stored so it is easy to remove
            s.groups[groupUsername].ingesterToGroup[ingesterAddress] = IngesterToGroup(true, s.ingesterClusters[clusterId].ingesterToAssignedGroups[ingesterAddress].length - 1);
            ++s.ingesterClusters[clusterId].clusterGroupCount;
            
            // Re-calculate clusterRemainingCapacity
            require((s.maxGroupsPerIngester * s.ingesterClusters[clusterId].ingesterAddresses.length) >= s.ingesterClusters[clusterId].clusterGroupCount, "More groups in cluster than cluster constraints");
            s.ingesterClusters[clusterId].clusterRemainingCapacity = (s.maxGroupsPerIngester * s.ingesterClusters[clusterId].ingesterAddresses.length) - s.ingesterClusters[clusterId].clusterGroupCount;
            emit IIngesterGroupManager.GroupDistributed(clusterId, groupUsername, ingesterAddress);
           
        }

    }

    function getMostCapacityCluster() internal view returns(uint256) {
        //need to calculate this for an adaptive metric depending on group size
        uint256 mostAvailableGroups = 0;
        uint256 mostAvailableClusterId = 0;
        for (uint256 i = 0; i < s.clusterIds.length; i++) {
            if (s.ingesterClusters[s.clusterIds[i]].clusterRemainingCapacity > mostAvailableGroups) {
                mostAvailableGroups = s.ingesterClusters[s.clusterIds[i]].clusterRemainingCapacity;
                mostAvailableClusterId = s.clusterIds[i];
            }
        }
        return mostAvailableClusterId;
    }

    function removeGroup(string calldata groupUsername) external onlyAdmin {
        require(s.groups[groupUsername].isAdded, "Group does not exist.");
        address[] memory ingesterAddresses = s.groups[groupUsername].ingesterAddresses;
        removeGroupFromCluster(s.groups[groupUsername].clusterId, groupUsername, ingesterAddresses);
        delete s.groupUsernames[s.groups[groupUsername].groupUsernameIndex];
        delete s.groups[groupUsername];
        --s.groupCount;
        emit IIngesterGroupManager.GroupRemoved(groupUsername);
    }

    function removeGroupFromCluster(uint256 clusterId, string calldata groupUsername, address[] memory ingesterAddresses) internal {
        //Currently there should only be one address per group, this implementation is here to support multiple ingester allocations to one group
        for (uint256 i = 0; i < ingesterAddresses.length; i++) {
            address currentIngesterAddress = ingesterAddresses[i];
            uint256 numAssignedGroups = s.ingesterClusters[clusterId].ingesterToAssignedGroups[currentIngesterAddress].length;
            uint256 groupClusterIndex = s.groups[groupUsername].ingesterToGroup[currentIngesterAddress].groupClusterIngesterIndex;
            //Re-adjust the ingesterToAssignedGroups array 
            if (groupClusterIndex != numAssignedGroups - 1) {
                string memory groupToMove = s.ingesterClusters[clusterId].ingesterToAssignedGroups[currentIngesterAddress][numAssignedGroups - 1];
                s.ingesterClusters[clusterId].ingesterToAssignedGroups[currentIngesterAddress][groupClusterIndex] = groupToMove;
            }
            s.ingesterClusters[clusterId].ingesterToAssignedGroups[currentIngesterAddress].pop();
            --s.ingesterClusters[clusterId].clusterGroupCount;
        }

        //update clusterRemainingCapacity metric on the cluster
        require((s.maxGroupsPerIngester * s.ingesterClusters[clusterId].ingesterAddresses.length) >= s.ingesterClusters[clusterId].clusterGroupCount, "More groups in cluster than cluster constraints");
        s.ingesterClusters[clusterId].clusterRemainingCapacity = (s.maxGroupsPerIngester * s.ingesterClusters[clusterId].ingesterAddresses.length) - s.ingesterClusters[clusterId].clusterGroupCount;
        emit IIngesterGroupManager.GroupRemovedFromCluster(clusterId, groupUsername);
    }
    
    function getGroup(string calldata groupUsername) external view returns (IIngesterGroupManager.GroupSlim memory) {
        IIngesterGroupManager.GroupSlim memory group = IIngesterGroupManager.GroupSlim(
            s.groups[groupUsername].isAdded,
            s.groups[groupUsername].clusterId,
            s.groups[groupUsername].ingesterAddresses, 
            s.groups[groupUsername].groupUsernameIndex
        );
        return group;
    }

    /**
    * @notice Retrieves the maximum cluster size.
    * @return uint256 The maximum number of ingesters allowed in a cluster.
    */
    function getMaxClusterSize() external view returns (uint256) {
        return s.maxClusterSize;
    }

    function getMaxGroupsPerIngester() external view returns (uint256) {
        return s.maxGroupsPerIngester;
    }

    function getMaxIngestersPerGroup() external view returns (uint256) {
        return s.maxIngestersPerGroup;
    }



    function ceilDiv(uint256 a, uint256 b) public pure returns (uint256) {
        require(b != 0, "Division by zero");
        return (a + b - 1) / b;
    }
}
