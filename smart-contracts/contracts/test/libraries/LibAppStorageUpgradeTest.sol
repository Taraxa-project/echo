// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../../interfaces/IIngesterRegistration.sol";
import "../../interfaces/IIngesterGroupManager.sol";
import "../../interfaces/IIngesterDataGathering.sol";
import { LibDiamond } from "../../libraries/LibDiamond.sol";

struct AppStorageTest {
    //Registry
    mapping(address => IIngesterRegistration.IngesterToController) ingesterToController;
    mapping(address => IIngesterRegistration.Ingester[]) controllerToIngesters;
    address[] ingesterAddresses;
    uint256 ingesterCount;
    address[] unAllocatedIngesters;


    //Groups & Clusters
    uint256 maxClusterSize;
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

    //new storage property
    bool newTestProperty;
}

library LibAppStorageTest {

    bytes32 internal constant INGESTER_ROLE = keccak256("INGESTER_ROLE");
    bytes32 internal constant CONTROLLER_ROLE = keccak256("CONTROLLER_ROLE");
    
    event IngesterAddedToCluster(uint256 indexed clusterId, address indexed ingesterAddress);
    event UnAllocatedIngesterAdded(address indexed ingesterAddress);
    event ClusterHasNoIngesters(uint256 clusterId);
    event IngesterRemovedFromCluster(uint256 indexed clusterId, address indexed ingesterAddress);

    function appStorage() internal pure returns (AppStorageTest storage ds) {    
        assembly { ds.slot := 0 }
    }

    function setTestProperty(bool testProperty) internal {
        AppStorageTest storage s = appStorage();
        s.newTestProperty = testProperty;
    }

    function getTestProperty() internal view returns(bool) {
        AppStorageTest storage s = appStorage();
        return s.newTestProperty;
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
                    if (s.unAllocatedIngesters.length > 0) {
                        address unAllocatedIngester = s.unAllocatedIngesters[s.unAllocatedIngesters.length - 1];
                        s.unAllocatedIngesters.pop();
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
                } // TODO: check if we should steal an ingester from  another cluster
                break;
            }
        }
    }

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

    function addIngesterToClusterId(address ingesterAddress, uint256 clusterId) internal {
        AppStorageTest storage s = appStorage();

        s.groupsCluster[clusterId].ingesterAddresses.push(ingesterAddress);
        IIngesterRegistration.IngesterToController memory controller = s.ingesterToController[ingesterAddress];
        s.controllerToIngesters[controller.controllerAddress][controller.ingesterIndex].clusterId = clusterId;
        
        emit IngesterAddedToCluster(clusterId, ingesterAddress);
    }

    function addIngesterToCluster(address ingesterAddress, address controllerAddress) internal {
        AppStorageTest storage s = appStorage();

        bool foundAvailableCluster;
        uint256 clusterId = 0;
      
        (clusterId, foundAvailableCluster) = getAvailableClusterForIngesters(ingesterAddress, controllerAddress);
        
        //if no available cluster then put it in unAllocatedIngester otherwise allocate ingester
        if (!foundAvailableCluster) {
            //TODO: add an allocataled boolean to the ingesters, clusterId is default 0, this could be a problem
            //it will think it is always allocated to something and it shouldn't, .e.g getIngesterWithGroups
            s.unAllocatedIngesters.push(ingesterAddress);
            emit UnAllocatedIngesterAdded(ingesterAddress);
        } else {
            s.groupsCluster[clusterId].ingesterAddresses.push(ingesterAddress);
            uint256 ingesterIndex = s.ingesterToController[ingesterAddress].ingesterIndex;
            s.controllerToIngesters[controllerAddress][ingesterIndex].clusterId = clusterId;
            emit IngesterAddedToCluster(clusterId, ingesterAddress);
        }

    }

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

    function getAvailableClusterForIngesters(address ingesterAddress, address controllerAddress) internal view returns(uint256, bool) {
        AppStorageTest storage s = appStorage();

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

