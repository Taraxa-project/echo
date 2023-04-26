// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../interfaces/IIngesterRegistration.sol";
import "../interfaces/IIngesterGroupManager.sol";
import "../interfaces/IIngesterDataGathering.sol";
import { LibDiamond } from "./LibDiamond.sol";

struct AppStorage {
    //Registry
    mapping(address => IIngesterRegistration.Ingester) ingesters;
    mapping(address => IIngesterRegistration.IngesterToController) ingesterToController;
    mapping(address => IIngesterRegistration.Ingester[]) controllerToIngesters;
    address[] ingesterAddresses;
    uint256 ingesterCount;

    //Groups & Clusters
    uint256 maxClusterSize;
    uint256 maxGroupsPerIngester; 
    uint256 maxIngestersPerGroup;
    mapping(uint => IIngesterGroupManager.Cluster) ingesterClusters;
    uint256[] clusterIds;
    mapping(string => IIngesterGroupManager.Group) groups;
    string[] groupUsernames;
    uint256 groupCount;
    string[] unAllocatedGroups;

    //IPFS Storage
    mapping(address => IIngesterDataGathering.IpfsHash) _ipfsHashes;
}

library LibAppStorage {

    bytes32 internal constant INGESTER_ROLE = keccak256("INGESTER_ROLE");
    bytes32 internal constant CONTROLLER_ROLE = keccak256("CONTROLLER_ROLE");
    
    event UnAllocatedGroupsAdded(string[] groups);
    event IngesterRemovedFromGroup(address indexed ingesterAddress, string indexed groupId);
    event IngesterRegisteredGroups(address indexed ingesterAddress, string[] assignedGroups);


    function appStorage() internal pure returns (AppStorage storage ds) {    
        assembly { ds.slot := 0 }
    }

    function AddToUnAllocateGroups(string[] memory groups) internal {
        AppStorage storage s = appStorage();

        uint256 numGroups = groups.length;
        for (uint256 i = 0; i < numGroups; i++) {
            s.unAllocatedGroups.push(groups[i]);
        }

        emit UnAllocatedGroupsAdded(groups);
    }

    function getUnallocatedGroups() internal view returns(string[] memory) {
        AppStorage storage s = appStorage();
        return s.unAllocatedGroups;
    }

    function getIngesters() internal view returns (address[] memory) {
        AppStorage storage s = appStorage();
        address[] memory ingesterAddresses = s.ingesterAddresses;
        return ingesterAddresses;
    }

    function addIngesterToCluster(address ingesterAddress, address controllerAddress) internal returns(uint256) {
        AppStorage storage s = appStorage();

        uint256 clusterId = 0;
        if (s.clusterIds.length == 0) {
            s.clusterIds.push(clusterId);
        } else {
            clusterId = getAvailableCluster(ingesterAddress, controllerAddress);
        }
        
        s.ingesterClusters[clusterId].ingesterAddresses.push(ingesterAddress);
        require((s.maxGroupsPerIngester * s.ingesterClusters[clusterId].ingesterAddresses.length) >= s.ingesterClusters[clusterId].clusterGroupCount, "More groups in cluster than cluster constraints");
        s.ingesterClusters[clusterId].clusterRemainingCapacity = (s.maxGroupsPerIngester * s.ingesterClusters[clusterId].ingesterAddresses.length) - s.ingesterClusters[clusterId].clusterGroupCount;
       
        // emit IIngesterGroupManager.IngesterAddedToCluster(ingesterAddress, clusterId);
        return clusterId;
    }

     function getAvailableCluster(address ingesterAddress, address controllerAddress) internal returns (uint256) {
        AppStorage storage s = appStorage();

        uint256 availableCluster = 0;
        bool foundAvailableCluster = false;
        uint256 numClusters = s.clusterIds.length;

        //if there are unallocated groups, create new cluster
        if (s.unAllocatedGroups.length > 0) {
            s.clusterIds.push(numClusters);
            return numClusters;
        }

        //otherwise go through the existing clusters and get the first available one
        for (uint256 i = 0; i < numClusters; i++) {
            if (s.ingesterClusters[s.clusterIds[i]].ingesterAddresses.length < s.maxClusterSize) {
                availableCluster = s.clusterIds[i]; 
                foundAvailableCluster = true;

                //If there is Duplication.
                //Restrict more than one controller wallet owning one ingester per cluster
                if (s.maxIngestersPerGroup > 1) {
                    IIngesterRegistration.Ingester[] memory controllerIngesters = s.controllerToIngesters[controllerAddress];

                    for (uint j = 0; j < s.ingesterClusters[availableCluster].ingesterAddresses.length; j++) {
                        for (uint k = 0; k < controllerIngesters.length; k++) {
                            //controller ingester addresses match ingesterAddresses within the cluster and it's not the current ingester we are trying to assign
                            //continue looking for another cluster
                            if (s.ingesterClusters[availableCluster].ingesterAddresses[j] == controllerIngesters[k].ingesterAddress && s.ingesterClusters[availableCluster].ingesterAddresses[j] != ingesterAddress) {
                                foundAvailableCluster = false;
                            }
                        }
                    }
                    if (foundAvailableCluster) {
                        break;
                    }
                } else {
                    break;
                }
            }
        }
        if (!foundAvailableCluster) {
            //create new cluster
            availableCluster = numClusters;
            s.clusterIds.push(availableCluster);
            return availableCluster;
        } else {
            return availableCluster;
        }
    }

    function removeIngesterFromGroups(uint256 clusterId, address ingesterAddress) internal {
        AppStorage storage s = LibAppStorage.appStorage();

        string[] memory groups = s.ingesterClusters[clusterId].ingesterToAssignedGroups[ingesterAddress];
        for (uint256 i = 0; i < groups.length; ++i) {
            // These arrays are capped by the s.maxNumberIngesterPerGroup
            uint256 amountOfIngestersPerGroup = s.groups[groups[i]].ingesterAddresses.length;
            for (uint256 j = 0; j < amountOfIngestersPerGroup; j++) {
                if(s.groups[groups[i]].ingesterAddresses[j] == ingesterAddress ) {
                    //delete ingesterAddress from groups and readjust array length so s.maxNumberIngesterPerGroup check remains truthful
                    for (uint256 z = j; z < amountOfIngestersPerGroup - 1; ++z) {
                        s.groups[groups[i]].ingesterAddresses[z] = s.groups[groups[i]].ingesterAddresses[z+1];
                    }
                    s.groups[groups[i]].ingesterAddresses.pop();
                    emit IngesterRemovedFromGroup(ingesterAddress, groups[i]);
                    break;
                }
            }
        }
    }

    function removeIngesterFromCluster(address ingesterAddress, uint256 clusterId) internal {
        AppStorage storage s = LibAppStorage.appStorage();

        uint256 numIngesters = s.ingesterClusters[clusterId].ingesterAddresses.length;
        uint256 ingesterIndexToRemove = 0;
        for (uint256 i = 0; i < numIngesters; i++) {
            if (s.ingesterClusters[clusterId].ingesterAddresses[i] == ingesterAddress) {
                ingesterIndexToRemove = i;
                //Re-adjust the ingesterAddresses array 
                if (i != numIngesters - 1) {
                    address ingesterAddressToMove = s.ingesterClusters[clusterId].ingesterAddresses[numIngesters - 1];
                    s.ingesterClusters[clusterId].ingesterAddresses[i] = ingesterAddressToMove;
                }
                s.ingesterClusters[clusterId].ingesterAddresses.pop();

                if (s.ingesterClusters[clusterId].ingesterAddresses.length == 0) {
                    removeCluster(clusterId);
                    delete s.ingesterClusters[clusterId];
                } else {
                    //remove all assignedGroups from ingester within the cluster
                    s.ingesterClusters[clusterId].clusterGroupCount -= s.ingesterClusters[clusterId].ingesterToAssignedGroups[ingesterAddress].length;
                    s.ingesterClusters[clusterId].ingesterToAssignedGroups[ingesterAddress] = new string[](0);

                    //re-calculate cluster remaining capacity
                    require((s.maxGroupsPerIngester * s.ingesterClusters[clusterId].ingesterAddresses.length) >= s.ingesterClusters[clusterId].clusterGroupCount, "More groups in cluster than cluster constraints");
                    s.ingesterClusters[clusterId].clusterRemainingCapacity = (s.maxGroupsPerIngester * s.ingesterClusters[clusterId].ingesterAddresses.length) - s.ingesterClusters[clusterId].clusterGroupCount;
                    break;
                } 
            }
        }
    }

    /**
     * @dev Removes the specified cluster from the list of clusters.
     * @param clusterId The cluster ID to remove.
     */
    function removeCluster(uint256 clusterId) internal {
        AppStorage storage s = LibAppStorage.appStorage();

        uint256 clusterIndex = s.ingesterClusters[clusterId].clusterIndex;
        uint256 numClusters = s.clusterIds.length;
        if (clusterIndex != numClusters - 1) {
            uint256 clusterToMove = s.clusterIds[numClusters - 1];
            s.clusterIds[clusterIndex] = clusterToMove;
        }
        s.clusterIds.pop();
    }
}

