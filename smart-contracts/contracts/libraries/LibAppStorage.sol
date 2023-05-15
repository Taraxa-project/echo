// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../interfaces/IIngesterRegistration.sol";
import "../interfaces/IIngesterGroupManager.sol";
import "../interfaces/IIngesterDataGathering.sol";
import { LibDiamond } from "./LibDiamond.sol";
import "hardhat/console.sol";

struct AppStorage {
    //Registry
    mapping(address => IIngesterRegistration.IngesterToController) ingesterToController;
    mapping(address => IIngesterRegistration.Ingester[]) controllerToIngesters;
    address[] ingesterAddresses;
    uint256 ingesterCount;
    address[] unAllocatedIngesters;


    //Groups & Clusters
    uint256 maxClusterSize;
    uint256 maxGroupsPerIngester; 
    uint256 maxIngestersPerGroup;
    mapping(uint => IIngesterGroupManager.GroupsCluster) groupsCluster;
    uint256[] clusterIds;
    mapping(string => IIngesterGroupManager.Group) groups;
    string[] groupUsernames;
    uint256 groupCount;
    string[] unAllocatedGroups;
    uint256[] inActiveClusters;

    //IPFS Storage
    mapping(address => IIngesterDataGathering.IpfsHash) ipfsHashes;
}

library LibAppStorage {

    bytes32 internal constant INGESTER_ROLE = keccak256("INGESTER_ROLE");
    bytes32 internal constant CONTROLLER_ROLE = keccak256("CONTROLLER_ROLE");
    
    event UnAllocatedGroupsAdded(string[] groups);
    event IngesterAddedToCluster(address indexed ingesterAddress, uint256 indexed clusterId);
    event UnAllocatedIngesterAdded(address indexed ingesterAddress);
    event ClusterHasNoIngesters(uint256 clusterId);
    event IngesterRemovedFromCluster(uint256 indexed clusterId, address indexed ingesterAddress);


    function appStorage() internal pure returns (AppStorage storage ds) {    
        assembly { ds.slot := 0 }
    }
    
    /**
    * @notice Adds a list of group names to the unallocated groups.
    * @param groups An array of group names to be added to the unallocated groups.
    */
    function AddToUnAllocateGroups(string[] memory groups) internal {
        AppStorage storage s = appStorage();

        uint256 numGroups = groups.length;
        for (uint256 i = 0; i < numGroups; i++) {
            s.unAllocatedGroups.push(groups[i]);
        }

        emit UnAllocatedGroupsAdded(groups);
    }

    /**
    * @notice Retrieves the list of unallocated groups.
    * @return An array of unallocated group usernames.
    */
    function getUnallocatedGroups() internal view returns(string[] memory) {
        AppStorage storage s = appStorage();
        return s.unAllocatedGroups;
    }

    /**
    * @notice Removes an ingester from a cluster.
    * @param ingesterAddress The address of the ingester to be removed.
    * @param clusterId The ID of the cluster the ingester is being removed from.
    */
    function removeIngesterFromCluster(address ingesterAddress, uint256 clusterId) internal {
        AppStorage storage s = LibAppStorage.appStorage();

        uint256 numIngesters = s.groupsCluster[clusterId].ingesterAddresses.length;
        uint256 ingesterIndexToRemove = 0;
        for (uint256 i = 0; i < numIngesters; i++) {
            if (s.groupsCluster[clusterId].ingesterAddresses[i] == ingesterAddress) {
                ingesterIndexToRemove = i;
                //Re-adjust the ingesterAddresses array 
                if (i != numIngesters - 1) {
                    address ingesterAddressToMove = s.groupsCluster[clusterId].ingesterAddresses[numIngesters - 1];
                    s.groupsCluster[clusterId].ingesterAddresses[i] = ingesterAddressToMove;
                }
                s.groupsCluster[clusterId].ingesterAddresses.pop();
                emit IngesterRemovedFromCluster(clusterId, ingesterAddress);

                if (s.groupsCluster[clusterId].ingesterAddresses.length == 0) {
                    //check if there is unallocated ingesters to assign
                    if (s.unAllocatedIngesters.length > 0) {
                        address unAllocatedIngester = s.unAllocatedIngesters[s.unAllocatedIngesters.length - 1];
                        addIngesterToClusterId(unAllocatedIngester, s.ingesterToController[unAllocatedIngester].controllerAddress, clusterId);
                    } else if (s.maxIngestersPerGroup > 1) {
                        (uint clusterIdAvailable, bool foundAvailableCluster) = getClusterWithIngesterReplication();
                        //if available cluster, then steal ingester from available cluster and put it into empty cluster
                        if (foundAvailableCluster) {
                            address ingesterAddressToMove = s.groupsCluster[clusterIdAvailable].ingesterAddresses[s.groupsCluster[clusterIdAvailable].ingesterAddresses.length - 1];
                            s.groupsCluster[clusterId].ingesterAddresses.push(ingesterAddressToMove);
                            //update clusterId of moved ingester
                            IIngesterRegistration.IngesterToController memory controller = s.ingesterToController[ingesterAddressToMove];
                            s.controllerToIngesters[controller.controllerAddress][controller.ingesterIndex].clusterId = clusterId;
                        } else {
                            console.log('cluster has no ingesters inside the empty cluster clause');
                            emit ClusterHasNoIngesters(clusterId);
                        }
                    } else {
                        console.log('cluster has no ingesters');
                        emit ClusterHasNoIngesters(clusterId);
                    }
                } // TODO: check if we should steal an ingester from  another cluster
                break;
            }
        }
    }

    function addIngesterToClusterId(address ingesterAddress, address controllerAddress, uint256 clusterId) internal {
        AppStorage storage s = appStorage();

        s.groupsCluster[clusterId].ingesterAddresses.push(ingesterAddress);
        s.unAllocatedIngesters.pop();

        uint256 ingesterIndex = s.ingesterToController[ingesterAddress].ingesterIndex;
        s.controllerToIngesters[controllerAddress][ingesterIndex].clusterId = clusterId;
        
        emit IngesterAddedToCluster(ingesterAddress, clusterId);
    }

    function addIngesterToCluster(address ingesterAddress, address controllerAddress) internal {
        AppStorage storage s = appStorage();

        bool foundAvailableCluster;
        uint256 clusterId = 0;
      
        (clusterId, foundAvailableCluster) = getAvailableClusterForIngesters(ingesterAddress, controllerAddress);
        
        console.log('clusterId', clusterId);
        console.log('foundAvailableCluster', foundAvailableCluster);
        //if no available cluster then put it in unAllocatedIngester otherwise allocate ingester
        if (!foundAvailableCluster) {
            //TODO: add an allocataled boolean to the ingesters, clusterId is default 0, this could be a problem
            //it will think it is always allocated to something and it shouldn't
            s.unAllocatedIngesters.push(ingesterAddress);
            console.log('adding unallocated ingester', ingesterAddress);
            emit UnAllocatedIngesterAdded(ingesterAddress);
        } else {
            console.log('adding ingester to cluster', clusterId);
            s.groupsCluster[clusterId].ingesterAddresses.push(ingesterAddress);
            uint256 ingesterIndex = s.ingesterToController[ingesterAddress].ingesterIndex;
            console.log('ingester', ingesterAddress);
            s.controllerToIngesters[controllerAddress][ingesterIndex].clusterId = clusterId;
            console.log('clusterId it should be in', clusterId);
            console.log('storage is', s.controllerToIngesters[controllerAddress][ingesterIndex].clusterId);
            emit IngesterAddedToCluster(ingesterAddress, clusterId);
        }

    }

    function getClusterWithIngesterReplication() internal view returns(uint256, bool) {
        AppStorage storage s = appStorage();

        uint256 availableClusterId = 0;
        bool foundAvailableCluster = false;
        uint256 numClusters = s.clusterIds.length;

        for (uint256 i = 0; i < numClusters; i++) {
            if (s.groupsCluster[s.clusterIds[i]].ingesterAddresses.length > 1 && s.groupsCluster[s.clusterIds[i]].isActive) {
                availableClusterId = s.clusterIds[i];
                foundAvailableCluster = true;
            }
        }
        return (availableClusterId, foundAvailableCluster);
    }

    function getAvailableClusterForIngesters(address ingesterAddress, address controllerAddress) internal view returns(uint256, bool) {
        AppStorage storage s = appStorage();

        uint256 availableClusterId = 0;
        bool foundAvailableCluster = false;
        uint256 numClusters = s.clusterIds.length;

        //otherwise go through the existing clusters and get the first available one
        for (uint256 i = 0; i < numClusters; i++) {
            if (s.groupsCluster[s.clusterIds[i]].ingesterAddresses.length < s.maxIngestersPerGroup && s.groupsCluster[s.clusterIds[i]].isActive) {
                availableClusterId = s.clusterIds[i];
                foundAvailableCluster = true;
                //If there is Duplication.
                //Restrict more than one controller wallet owning one ingester per cluster
                if (s.maxIngestersPerGroup > 1) {
                    IIngesterRegistration.Ingester[] memory controllerIngesters = s.controllerToIngesters[controllerAddress];

                    for (uint j = 0; j < s.groupsCluster[availableClusterId].ingesterAddresses.length; j++) {
                        for (uint k = 0; k < controllerIngesters.length; k++) {
                            //controller ingester addresses match ingesterAddresses within the cluster and it's not the current ingester we are trying to assign
                            //continue looking for another cluster
                            if (s.groupsCluster[availableClusterId].ingesterAddresses[j] == controllerIngesters[k].ingesterAddress && s.groupsCluster[availableClusterId].ingesterAddresses[j] != ingesterAddress) {
                                foundAvailableCluster = false;
                            }
                        }
                    }
                } 

                if (foundAvailableCluster) {
                    break;
                }
            }
        }

        return (availableClusterId, foundAvailableCluster);
    }
}

