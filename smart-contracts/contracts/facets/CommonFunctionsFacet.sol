
// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import "../libraries/LibDiamond.sol";
import { LibAppStorage, AppStorage } from  "../libraries/LibAppStorage.sol";
import "../interfaces/IIngesterGroupManager.sol";
import "../interfaces/IIngesterRegistration.sol";

contract CommonFunctionsFacet {
    AppStorage internal s;
    
    /**
    * @notice Retrieves the list of unallocated groups.
    * @return An array of unallocated group usernames.
    */
    function getunallocatedGroups() external view returns(string[] memory) {
        uint256 groupCount = 0;
        for (uint256 i = 0; i < s.clusterIds.length;) {
            if (s.groupsCluster[s.clusterIds[i]].ingesterAddresses.length == 0) {
                groupCount += s.groupsCluster[s.clusterIds[i]].groupUsernames.length;
            }
            unchecked {
                ++i;
            }
        }

        string[] memory groups = new string[](groupCount);
        uint256 index = 0;

        for (uint256 i = 0; i < s.clusterIds.length;) {
            if (s.groupsCluster[s.clusterIds[i]].ingesterAddresses.length == 0) {
                uint256 groupsLength = s.groupsCluster[s.clusterIds[i]].groupUsernames.length;
                for ( uint256 j = 0; j < groupsLength;) {
                    groups[index] = s.groupsCluster[s.clusterIds[i]].groupUsernames[j];
                    ++index;
                    unchecked {
                        ++j;
                    }
                }
            }
            unchecked {
                ++i;
            }
        }
        
        return groups;
    }

    /**
    * @notice Retrieves the list of cluster IDs.
    * @return An array of cluster IDs.
    */
    function getClusters() external view returns (uint256[] memory){
        return s.clusterIds;
    }
    
     /**
    * @notice Retrieves the list of active cluster IDs.
    * @return An array of active cluster IDs.
    */
    function getActiveClusters() external view returns (uint256[] memory) {
        uint256 activeCount = 0;
        for (uint256 i = 0; i < s.clusterIds.length;) {
            if (s.groupsCluster[s.clusterIds[i]].isActive) {
                activeCount++;
            }
            unchecked {
                ++i;
            }
        }

        uint256[] memory clusterIds = new uint256[](activeCount);
        
        uint256 index = 0;
        for (uint256 i = 0; i < s.clusterIds.length;) {
            if (s.groupsCluster[s.clusterIds[i]].isActive) {
                clusterIds[index] = s.clusterIds[i];
                index++;
            }
            unchecked {
                ++i;
            }
        }
        
        return clusterIds;
    }

    /**
    * @notice Retrieves the total number of clusters.
    * @return The count of total clusters.
    */
    function getClusterCount() external view returns (uint256){
        return s.clusterIds.length;
    }

    /**
    * @notice Retrieves the list of inactive cluster IDs.
    * @return An array of inactive cluster IDs.
    */
    function getinactiveClusters() external view returns (uint256[] memory){
        return s.inactiveClusters;
    }

    /**
    * @notice Retrieves the details of a cluster by its ID.
    * @param clusterId The ID of the cluster to retrieve.
    * @return ClusterSlim struct containing the cluster's details.
    */
    function getCluster(uint256 clusterId) external view returns (IIngesterGroupManager.GroupsCluster memory) {
        return s.groupsCluster[clusterId];
    }

    /**
    * @notice Retrieves the total number of registered ingesters.
    * @return The count of total registered ingesters.
    */
    function getIngesterCount() external view returns(uint256) {
        return s.ingesterAddresses.length;
    }

    /**
    * @notice Retrieves the details of a registered ingester.
    * @param ingesterAddress The address of the registered ingester.
    * @return An Ingester struct containing the ingester's details.
    */
    function getIngester(address ingesterAddress) public view returns (IIngesterRegistration.Ingester memory) {
        require(s.ingesterToController[ingesterAddress].controllerAddress != address(0), "Ingester does not exist.");
        address controller = s.ingesterToController[ingesterAddress].controllerAddress;
        uint ingesterIndex = s.ingesterToController[ingesterAddress].ingesterIndex;

        return s.controllerToIngesters[controller][ingesterIndex];
    }

    /**
    * @notice Retrieves the addresses of all registered ingesters.
    * @return An address aray containing the registered ingesters.
    */
    function getIngesters() public view returns (address[] memory) {
        address[] memory ingesterAddresses = s.ingesterAddresses;
        return ingesterAddresses;
    }

    /**
    * @notice Retrieves the details of a registered ingester including assigned groups.
    * @param ingesterAddress The address of the registered ingester.
    * @return An IngesterWithGroups struct containing the ingester's details and its assigned groups.
    */
    function getIngesterWithGroups(address ingesterAddress) public view returns (IIngesterRegistration.IngesterWithGroups memory) {
        require(s.ingesterToController[ingesterAddress].controllerAddress != address(0), "Ingester does not exist.");
        address controller = s.ingesterToController[ingesterAddress].controllerAddress;
        uint ingesterIndex = s.ingesterToController[ingesterAddress].ingesterIndex;
        IIngesterRegistration.Ingester memory ingester = s.controllerToIngesters[controller][ingesterIndex];
        if (!ingester.isAllocated) {
            string[] memory assignedGroups = new string[](0);
            IIngesterRegistration.IngesterWithGroups memory ingesterWithAssignedGroups = IIngesterRegistration.IngesterWithGroups(
                ingesterAddress,
                ingester.isAllocated,
                ingester.clusterId,
                assignedGroups
            );
            return ingesterWithAssignedGroups;
        } else {
             string[] memory assignedGroups = s.groupsCluster[ingester.clusterId].groupUsernames;
            IIngesterRegistration.IngesterWithGroups memory ingesterWithAssignedGroups = IIngesterRegistration.IngesterWithGroups(
                ingesterAddress,
                ingester.isAllocated,
                ingester.clusterId,
                assignedGroups
            );
            return ingesterWithAssignedGroups;
        }
    }

    /**
    * @notice Retrieves the list of unallocated ingesters.
    * @return An array of unallocated ingester addresses.
    */
    function getunallocatedIngesters() public view returns (address[] memory) {
        return  s.unallocatedIngesters;
    }

    /**
    * @notice Retrieves the list of ingesters for a given controller.
    * @param controllerAddress The address of the controller.
    * @return An array of Ingester structs containing the details of
    */
    function getControllerIngesters(address controllerAddress) public view returns (IIngesterRegistration.Ingester[] memory) {
        return s.controllerToIngesters[controllerAddress];
    }


    /**
    * @notice Retrieves the controller of an ingester.
    * @param ingesterAddress The address of the ingester.
    * @return The address of the controller
    */
    function getIngesterController(address ingesterAddress) public view returns (address) {
        return s.ingesterToController[ingesterAddress].controllerAddress;
    }

    /**
    * @notice Retrieves the total number of groups.
    * @return The count of total groups.
    */
    function getGroupCount() external view returns(uint256) {
        return s.groupUsernames.length;
    }

    /**
    * @notice Retrieves the groups usernames.
    * @return An array with all the added groups
    */
    function getGroups() external view returns(string[] memory) {
        return s.groupUsernames;
    }

}
