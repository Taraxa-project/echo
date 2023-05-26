// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import "../interfaces/IIngesterRegistration.sol";
import "../interfaces/IIngesterGroupManager.sol";
import "../interfaces/IIngesterDataGathering.sol";
import { LibDiamond } from "./LibDiamond.sol";

struct AppStorage {
    //Registry
    mapping(address => IIngesterRegistration.IngesterToController) ingesterToController;
    mapping(address => IIngesterRegistration.Ingester[]) controllerToIngesters;
    address[] ingesterAddresses;
    address[] unallocatedIngesters;


    //Groups & Clusters
    uint256 maxClusterSize;
    uint256 maxIngestersPerGroup;
    mapping(uint256 => IIngesterGroupManager.GroupsCluster) groupsCluster;
    uint256[] clusterIds;
    mapping(string => IIngesterGroupManager.Group) groups;
    string[] groupUsernames;
    string[] unallocatedGroups;
    uint256[] inactiveClusters;

    //IPFS Storage
    mapping(address => IIngesterDataGathering.IpfsHash) ipfsHashes;
}

library LibAppStorage {

    bytes32 internal constant _INGESTER_ROLE = keccak256("INGESTER_ROLE");
    bytes32 internal constant _CONTROLLER_ROLE = keccak256("CONTROLLER_ROLE");
    
    event IngesterAddedToCluster(uint256 indexed clusterId, address indexed ingesterAddress);
    event UnAllocatedIngesterAdded(address indexed ingesterAddress);
    event ClusterHasNoIngesters(uint256 clusterId);
    event IngesterRemovedFromCluster(uint256 indexed clusterId, address indexed ingesterAddress);


    /**
    * @notice Retrieves the AppStorage state.
    * @return ds AppStorage The current state of the AppStorage.
    */
    function appStorage() internal pure returns (AppStorage storage ds) {    
        assembly { ds.slot := 0 }
    }
    
    /**
    * @notice Removes an ingester from a cluster.
    * @param ingesterAddress The address of the ingester to be removed.
    * @param clusterId The ID of the cluster the ingester is being removed from.
    */
    function removeIngesterFromCluster(address ingesterAddress, uint256 clusterId) internal {
        AppStorage storage s = LibAppStorage.appStorage();

        uint256 numIngesters = s.groupsCluster[clusterId].ingesterAddresses.length;
        for (uint256 i = 0; i < numIngesters;) {
            if (s.groupsCluster[clusterId].ingesterAddresses[i] == ingesterAddress) {
                //Re-adjust the ingesterAddresses array 
                if (i != numIngesters - 1) {
                    address ingesterAddressToMove = s.groupsCluster[clusterId].ingesterAddresses[numIngesters - 1];
                    s.groupsCluster[clusterId].ingesterAddresses[i] = ingesterAddressToMove;
                }
                s.groupsCluster[clusterId].ingesterAddresses.pop();
                emit IngesterRemovedFromCluster(clusterId, ingesterAddress);

                //check if there is unallocated ingesters to assign
                if (s.unallocatedIngesters.length > 0) {
                    address unAllocatedIngester = s.unallocatedIngesters[s.unallocatedIngesters.length - 1];
                    s.unallocatedIngesters.pop();
                    addIngesterToClusterId(unAllocatedIngester, clusterId);
                }
                else if (s.groupsCluster[clusterId].ingesterAddresses.length == 0) {
                    
                    if (s.maxIngestersPerGroup > 1) {
                        (uint clusterIdAvailable, bool foundAvailableCluster) = getClusterWithMostIngesterReplication();
                        //if available cluster, then steal ingester from available cluster and put it into empty cluster
                        if (foundAvailableCluster) {
                            fetchIngesterFromAvailableCluster(clusterIdAvailable, clusterId);
                        } else {
                            emit ClusterHasNoIngesters(clusterId);
                        }
                    } else {
                        emit ClusterHasNoIngesters(clusterId);
                    }
                } 
                break;
            }
            unchecked {
                ++i;
            }
        }
    }

    /**
    * @notice Fetches an ingester from an available cluster and assigns it to a specified cluster.
    * @param fetchClusterId The ID of the cluster to fetch the ingester from.
    * @param assignClusterId The ID of the cluster to assign the fetched ingester to.
    */
    function fetchIngesterFromAvailableCluster(uint256 fetchClusterId, uint256 assignClusterId) internal {
        AppStorage storage s = appStorage();

        //fetch from fetchClusterId
        uint256 numIngesters = s.groupsCluster[fetchClusterId].ingesterAddresses.length;
        address ingesterAddressToMove = s.groupsCluster[fetchClusterId].ingesterAddresses[numIngesters - 1];
        s.groupsCluster[fetchClusterId].ingesterAddresses.pop();
        emit IngesterRemovedFromCluster(fetchClusterId, ingesterAddressToMove);

        //assign ingester to assignClusterId
        addIngesterToClusterId(ingesterAddressToMove, assignClusterId);
    }

    /**
    * @notice Adds an ingester to a specified cluster.
    * @param ingesterAddress The address of the ingester to be added.
    * @param clusterId The ID of the cluster the ingester is being added to.
    */
    function addIngesterToClusterId(address ingesterAddress, uint256 clusterId) internal {
        AppStorage storage s = appStorage();

        s.groupsCluster[clusterId].ingesterAddresses.push(ingesterAddress);
        IIngesterRegistration.IngesterToController storage controller = s.ingesterToController[ingesterAddress];
        s.controllerToIngesters[controller.controllerAddress][controller.ingesterIndex].clusterId = clusterId;
        s.controllerToIngesters[controller.controllerAddress][controller.ingesterIndex].isAllocated = true;
        
        emit IngesterAddedToCluster(clusterId, ingesterAddress);
    }
    

    /**
    * @notice Adds an ingester to a cluster.
    * @param ingesterAddress The address of the ingester to be added.
    * @param controllerAddress The address of the controller of the ingester.
    */
    function addIngesterToCluster(address ingesterAddress, address controllerAddress) internal {
        AppStorage storage s = appStorage();

        bool foundAvailableCluster;
        uint256 clusterId = 0;
      
        (clusterId, foundAvailableCluster) = getAvailableClusterForIngesters(ingesterAddress, controllerAddress);
        
        //if no available cluster then put it in unAllocatedIngester otherwise allocate ingester
        if (!foundAvailableCluster) {
            uint256 ingesterIndex = s.ingesterToController[ingesterAddress].ingesterIndex;
            s.controllerToIngesters[controllerAddress][ingesterIndex].isAllocated = false;
            s.unallocatedIngesters.push(ingesterAddress);
            emit UnAllocatedIngesterAdded(ingesterAddress);
        } else {
            addIngesterToClusterId(ingesterAddress, clusterId);
        }

    }

    /**
    * @notice Retrieves the ID of a cluster with the most ingester replication.
    * @return uint256 The ID of the cluster.
    * @return bool A boolean value indicating if a cluster with ingester replication was found.
    */
    function getClusterWithMostIngesterReplication() internal view returns(uint256, bool) {
        AppStorage storage s = appStorage();

        uint256 availableClusterId = 0;
        bool foundAvailableCluster = false;
        uint256 numClusters = s.clusterIds.length;
        uint256 minIngesterReplication = 0;

        for (uint256 i = 0; i < numClusters; i++) {
            uint256 numIngesters = s.groupsCluster[s.clusterIds[i]].ingesterAddresses.length;

            if (numIngesters > minIngesterReplication && numIngesters > 1 && s.groupsCluster[s.clusterIds[i]].isActive) {
                availableClusterId = s.clusterIds[i];
                foundAvailableCluster = true;
            }
        }
        return (availableClusterId, foundAvailableCluster);
    }

    function sortGroupClustersByIngesterAvailability(bool isAscending) internal view returns(uint256[] memory) {
        AppStorage storage s = appStorage();
        uint256 numClusters = s.clusterIds.length;

        uint256[] memory sortedClusterIds = new uint256[](numClusters);
        for (uint256 i = 0; i < numClusters; i++) {
            sortedClusterIds[i] = s.clusterIds[i];
        }

        // Sort the clusters by the number of ingesters
        for (uint256 i = 0; i < numClusters; i++) {
            for (uint256 j = 0; j < numClusters - i - 1; j++) {
                // Sort in ascending order if isAscending is true, otherwise sort in descending order
                if ((isAscending && s.groupsCluster[sortedClusterIds[j]].ingesterAddresses.length > s.groupsCluster[sortedClusterIds[j + 1]].ingesterAddresses.length)
                    || (!isAscending && s.groupsCluster[sortedClusterIds[j]].ingesterAddresses.length < s.groupsCluster[sortedClusterIds[j + 1]].ingesterAddresses.length)) {
                    uint256 temp = sortedClusterIds[j];
                    sortedClusterIds[j] = sortedClusterIds[j + 1];
                    sortedClusterIds[j + 1] = temp;
                }
            }
        }

        return sortedClusterIds;
    }

    function getAvailableClusterForIngesters(address ingesterAddress, address controllerAddress) internal view returns(uint256, bool) {
        AppStorage storage s = appStorage();
        bool ascendingOrder = true;
        uint256[] memory sortedClusterIds = sortGroupClustersByIngesterAvailability(ascendingOrder);

        uint256 availableClusterId = 0;
        bool foundAvailableCluster = false;
        
        for (uint256 i = 0; i < sortedClusterIds.length; i++) {
            availableClusterId = sortedClusterIds[i];
            IIngesterGroupManager.GroupsCluster storage currentCluster = s.groupsCluster[availableClusterId];

            // Check if the cluster is active and has space for an additional ingester
            if (currentCluster.isActive && currentCluster.ingesterAddresses.length < s.maxIngestersPerGroup) {
                if (s.maxIngestersPerGroup > 1) {
                    bool hasSameControllerIngester = hasSameControllerIngester(availableClusterId, controllerAddress);
                    
                    // If the cluster doesn't have the same controller ingester, it's a candidate
                    if (!hasSameControllerIngester) {
                        return (availableClusterId, true);
                    }
                } else {
                    return (availableClusterId, true);
                }
            }
        }

        return (availableClusterId, foundAvailableCluster);
    }

    function hasSameControllerIngester(uint256 clusterId, address controllerAddress) internal view returns(bool) {
        AppStorage storage s = appStorage();
        IIngesterGroupManager.GroupsCluster storage currentCluster = s.groupsCluster[clusterId];
        uint256 numIngesters = currentCluster.ingesterAddresses.length;

        // If there is more than one controller wallet owning one ingester per cluster, check for same controller ingestor
        if (s.maxIngestersPerGroup > 1) {
            IIngesterRegistration.Ingester[] storage controllerIngesters = s.controllerToIngesters[controllerAddress];

            for (uint j = 0; j < numIngesters; j++) {
                for (uint k = 0; k < controllerIngesters.length; k++) {
                    if (currentCluster.ingesterAddresses[j] == controllerIngesters[k].ingesterAddress) {
                        return true;
                    }
                }
            }
        }
        return false;
    }
}

