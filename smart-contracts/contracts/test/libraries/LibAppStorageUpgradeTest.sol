// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import "../../interfaces/IIngesterRegistration.sol";
import "../../interfaces/IIngesterGroupManager.sol";
import "../../interfaces/IIngesterDataGathering.sol";
import { LibDiamond } from "../../libraries/LibDiamond.sol";

struct AppStorageTest {
    //Registry
    mapping(address => IIngesterRegistration.IngesterToController) ingesterToController;
    mapping(address => IIngesterRegistration.Ingester[]) controllerToIngesters;
    address[] ingesterAddresses;
    address[] unallocatedIngesters;


    //Groups & Clusters
    uint256 maxClusterSize;
    uint256 maxIngestersPerGroup;
    mapping(uint => IIngesterGroupManager.GroupsCluster) groupsCluster;
    uint256[] clusterIds;
    mapping(string => IIngesterGroupManager.Group) groups;
    string[] groupUsernames;
    string[] unallocatedGroups;
    uint256[] inactiveClusters;

    //IPFS Storage
    mapping(address => IIngesterDataGathering.IpfsHash) ipfsHashes;

    //new storage property
    bool newTestProperty;
}

library LibAppStorageTest {

    bytes32 internal constant _INGESTER_ROLE = keccak256("INGESTER_ROLE");
    bytes32 internal constant _CONTROLLER_ROLE = keccak256("CONTROLLER_ROLE");
    
    event IngesterAddedToCluster(uint256 indexed clusterId, address indexed ingesterAddress);
    event UnAllocatedIngesterAdded(address indexed ingesterAddress);
    event ClusterHasNoIngesters(uint256 clusterId);
    event IngesterRemovedFromCluster(uint256 indexed clusterId, address indexed ingesterAddress);

    function setTestProperty(bool testProperty) internal {
        AppStorageTest storage s = appStorage();
        s.newTestProperty = testProperty;
    }

    function getTestProperty() internal view returns(bool) {
        AppStorageTest storage s = appStorage();
        return s.newTestProperty;
    }

    /**
    * @notice Retrieves the AppStorageTest state.
    * @return ds AppStorageTest The current state of the AppStorageTest.
    */
    function appStorage() internal pure returns (AppStorageTest storage ds) {    
        assembly { ds.slot := 0 }
    }
    
    /**
    * @notice Removes an ingester from a cluster.
    * @param ingesterAddress The address of the ingester to be removed.
    * @param clusterId The ID of the cluster the ingester is being removed from.
    */
    function removeIngesterFromCluster(address ingesterAddress, uint256 clusterId) internal {
        AppStorageTest storage s = LibAppStorageTest.appStorage();

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
                    if (s.unallocatedIngesters.length > 0) {
                        address unAllocatedIngester = s.unallocatedIngesters[s.unallocatedIngesters.length - 1];
                        s.unallocatedIngesters.pop();
                        addIngesterToClusterId(unAllocatedIngester, clusterId);
                    } else if (s.maxIngestersPerGroup > 1) {
                        (uint clusterIdAvailable, bool foundAvailableCluster) = getClusterWithIngesterReplication();
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
        }
    }

    /**
    * @notice Fetches an ingester from an available cluster and assigns it to a specified cluster.
    * @param fetchClusterId The ID of the cluster to fetch the ingester from.
    * @param assignClusterId The ID of the cluster to assign the fetched ingester to.
    */
    function fetchIngesterFromAvailableCluster(uint256 fetchClusterId, uint256 assignClusterId) internal {
        AppStorageTest storage s = appStorage();

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
        AppStorageTest storage s = appStorage();

        s.groupsCluster[clusterId].ingesterAddresses.push(ingesterAddress);
        IIngesterRegistration.IngesterToController memory controller = s.ingesterToController[ingesterAddress];
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
        AppStorageTest storage s = appStorage();

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
            s.groupsCluster[clusterId].ingesterAddresses.push(ingesterAddress);
            uint256 ingesterIndex = s.ingesterToController[ingesterAddress].ingesterIndex;
            s.controllerToIngesters[controllerAddress][ingesterIndex].clusterId = clusterId;
            s.controllerToIngesters[controllerAddress][ingesterIndex].isAllocated = true;
            emit IngesterAddedToCluster(clusterId, ingesterAddress);
        }

    }

    /**
    * @notice Retrieves the ID of a cluster with ingester replication.
    * @return uint256 The ID of the cluster.
    * @return bool A boolean value indicating if a cluster with ingester replication was found.
    */
    function getClusterWithIngesterReplication() internal view returns(uint256, bool) {
        AppStorageTest storage s = appStorage();

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

    /**
    * @notice Retrieves the ID of an available cluster for ingesters.
    * @param ingesterAddress The address of the ingester.
    * @param controllerAddress The address of the controller of the ingester.
    * @return uint256 The ID of the available cluster.
    * @return bool A boolean value indicating if an available cluster for ingesters was found.
    */
    function getAvailableClusterForIngesters(address ingesterAddress, address controllerAddress) internal view returns(uint256, bool) {
        AppStorageTest storage s = appStorage();

        uint256 availableClusterId = 0;
        bool foundAvailableCluster = false;
        uint256 numClusters = s.clusterIds.length;
        uint256 minNumIngesters = type(uint256).max;

        // First find the absolute minimum number of ingestors across all clusters
        for (uint256 i = 0; i < numClusters; i++) {
            IIngesterGroupManager.GroupsCluster storage currentCluster = s.groupsCluster[s.clusterIds[i]];
            uint256 numIngesters = currentCluster.ingesterAddresses.length;
            if (numIngesters < minNumIngesters) {
                minNumIngesters = numIngesters;
            }
        }

        // Then assign the ingestor to the cluster with minimum number of ingestors and without any ingestor controlled by the same controller wallet
        for (uint256 i = 0; i < numClusters; i++) {
            IIngesterGroupManager.GroupsCluster storage currentCluster = s.groupsCluster[s.clusterIds[i]];
            uint256 numIngesters = currentCluster.ingesterAddresses.length;

            // If the cluster is active and has the minimum number of ingestors
            if (numIngesters == minNumIngesters && numIngesters < s.maxIngestersPerGroup && currentCluster.isActive) {
                bool hasSameControllerIngester = false;

                // If there is more than one controller wallet owning one ingester per cluster, check for same controller ingestor
                if (s.maxIngestersPerGroup > 1) {
                    IIngesterRegistration.Ingester[] memory controllerIngesters = s.controllerToIngesters[controllerAddress];

                    for (uint j = 0; j < numIngesters; j++) {
                        for (uint k = 0; k < controllerIngesters.length; k++) {
                            if (currentCluster.ingesterAddresses[j] == controllerIngesters[k].ingesterAddress && currentCluster.ingesterAddresses[j] != ingesterAddress) {
                                hasSameControllerIngester = true;
                                break;
                            }
                        }

                        if (hasSameControllerIngester) {
                            break;
                        }
                    }
                }

                // If the cluster doesn't have the same controller ingestor, it's a candidate
                if (!hasSameControllerIngester) {
                    availableClusterId = s.clusterIds[i];
                    foundAvailableCluster = true;
                    break;
                }
            }
        }

        return (availableClusterId, foundAvailableCluster);
    }
}

