// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { LibAppStorageTest, AppStorageTest } from  "../libraries/LibAppStorageUpgradeTest.sol";
import "../../interfaces/IIngesterGroupManager.sol";
import "./AccessControlFacetTest.sol";
import "./CommonFunctionsFacetTest.sol";

contract GroupManagerFacetTest is AccessControlFacetTest, CommonFunctionsFacetTest, IIngesterGroupManager {

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
                maxGroupsPerIngester = divideAndRoundUp((numClusterGroups + numIngesters - 1), numIngesters);
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

     /**
     * @dev Distributes groups to the specified ingester address.
     * @param ingesterAddress The ingester address to distribute groups to.
     */
    function distributeGroupsToIngester(address ingesterAddress) external onlyRegisteredController {
        require(isIngesterOwnedByController(ingesterAddress, msg.sender), "Ingester is not owned by controller wallet");
        
        uint numUnallocatedGroups = s.unAllocatedGroups.length;
        uint256 clusterId = getIngester(ingesterAddress).clusterId;

        //prioritise allocation groups
        if (numUnallocatedGroups > 0) {
            uint256 clusterCapacity = s.ingesterClusters[clusterId].clusterRemainingCapacity;

            if (numUnallocatedGroups > clusterCapacity) {
                uint256 allocatableAmount = numUnallocatedGroups - clusterCapacity;
                while (s.unAllocatedGroups.length > allocatableAmount) {
                    uint256 i = s.unAllocatedGroups.length - 1;
                    distributeGroupToIngester(s.unAllocatedGroups[i], clusterId, ingesterAddress);
                    emit IIngesterGroupManager.RemoveUnallocatedGroup(s.unAllocatedGroups[i]);
                    s.unAllocatedGroups.pop();
                }
            } else {
                while (s.unAllocatedGroups.length > 0) {
                    uint256 i = s.unAllocatedGroups.length - 1;
                    distributeGroupToIngester(s.unAllocatedGroups[i], clusterId, ingesterAddress);
                    emit IIngesterGroupManager.RemoveUnallocatedGroup(s.unAllocatedGroups[i]);
                    s.unAllocatedGroups.pop();
                }
            }

        } else {
            if (s.maxIngestersPerGroup > 1) {
                //accounting for group replication scenario, simply assign present groups to cluster
                address ingesterToCopyGroupsFrom = s.ingesterClusters[clusterId].ingesterAddresses[0];
                string[] memory groupsToAllocate = s.ingesterClusters[clusterId].ingesterToAssignedGroups[ingesterToCopyGroupsFrom];
                for (uint i = 0; i < groupsToAllocate.length; i++) {
                    distributeGroupToIngester(groupsToAllocate[i], clusterId, ingesterAddress);
                }
            } else {
                revert("No more groups to allocate.");
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

    function distributeUnallocatedGroups() external {
        uint mostCapacityClusterId = getMostCapacityCluster();
        uint256 clusterCapacity = s.ingesterClusters[mostCapacityClusterId].clusterRemainingCapacity;
        uint256 amountOfGroups = s.unAllocatedGroups.length;

        if (amountOfGroups > clusterCapacity) {
            uint256 allocatableAmount = amountOfGroups - clusterCapacity;
            while (s.unAllocatedGroups.length > allocatableAmount) {
                uint256 i = s.unAllocatedGroups.length - 1;

                distributeGroupsToCluster(s.unAllocatedGroups[i], mostCapacityClusterId);
                emit IIngesterGroupManager.RemoveUnallocatedGroup(s.unAllocatedGroups[i]);
                s.unAllocatedGroups.pop();
            }
        } else {
            while (s.unAllocatedGroups.length > 0) {
                uint256 i = s.unAllocatedGroups.length - 1;
                distributeGroupsToCluster(s.unAllocatedGroups[i], mostCapacityClusterId);
                emit IIngesterGroupManager.RemoveUnallocatedGroup(s.unAllocatedGroups[i]);
                s.unAllocatedGroups.pop();
            }
        }
    }

    /**
     * @dev Distributes a group to the specified cluster.
     * @param groupUsername The group username to distribute.
     * @param clusterId The cluster ID to distribute the group to.
     */
    function distributeGroupsToCluster(string memory groupUsername, uint256 clusterId) internal {

        uint256 numIngesters = s.ingesterClusters[clusterId].ingesterAddresses.length;
        if (numIngesters == 1) {
            distributeGroupToIngester(groupUsername, clusterId, s.ingesterClusters[clusterId].ingesterAddresses[0]);
        } else {
            uint256 maxGroupsPerIngester = 1;
            uint256 numClusterGroups = s.ingesterClusters[clusterId].clusterGroupCount;

            //formula to apply a balanced distribution of groups across the ingesters
            if (numClusterGroups > 0) {
                maxGroupsPerIngester = divideAndRoundUp((numClusterGroups + numIngesters - 1) , numIngesters);
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
                    if ( i >= s.maxIngestersPerGroup - 1) {
                        break;
                    }
                }
            }
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

    function getMaxClusterSize() external view returns (uint256) {
        return s.maxClusterSize;
    }

    function getMaxGroupsPerIngester() external view returns (uint256) {
        return s.maxGroupsPerIngester;
    }

    function getMaxIngestersPerGroup() external view returns (uint256) {
        return s.maxIngestersPerGroup;
    }

    function setMaxClusterSize(uint256 maxClusterSize) external onlyAdmin {
        s.maxClusterSize = maxClusterSize;
        emit IIngesterGroupManager.MaxClusterSizeUpdated(maxClusterSize);
    }

    function setMaxGroupsPerIngester(uint256 maxGroupsPerIngester) external onlyAdmin {
        s.maxGroupsPerIngester = maxGroupsPerIngester;
        emit IIngesterGroupManager.MaxGroupsPerIngesterUpdated(maxGroupsPerIngester);
    }  

    function setMaxIngestersPerGroup(uint256 maxIngestersPerGroup) external  {
        require(maxIngestersPerGroup >= 1, "Can only set max ingester per group >= 1");
        s.maxIngestersPerGroup = maxIngestersPerGroup;
        emit IIngesterGroupManager.MaxIngesterPerGroupUpdated(maxIngestersPerGroup);
    }

    function getGroupUsernameByIndex(uint256 groupIndex) external view returns (string memory) {
        return s.groupUsernames[groupIndex];
    }
}
