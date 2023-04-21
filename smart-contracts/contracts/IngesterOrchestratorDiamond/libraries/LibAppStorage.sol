// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../interfaces/IIngesterRegistration.sol";
import "../interfaces/IIngesterGroupManager.sol";
import "../interfaces/IIngesterDataGathering.sol";
import "@solidstate/contracts/access/access_control/AccessControl.sol";
import "@solidstate/contracts/access/access_control/AccessControlStorage.sol";
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
    uint256 maxNumberIngesterPerGroup;
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


    function appStorage() internal pure returns (AppStorage storage ds) {    
        assembly { ds.slot := 0 }
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
                if (s.maxNumberIngesterPerGroup > 1) {
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

}

