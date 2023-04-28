
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

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
    function getUnallocatedGroups() external view returns(string[] memory) {
        return s.unAllocatedGroups;
    }

    /**
    * @notice Retrieves the list of cluster IDs.
    * @return An array of cluster IDs.
    */
    function getClusters() external view returns (uint256[] memory){
        return s.clusterIds;
    }

    /**
    * @notice Retrieves the details of a cluster by its ID.
    * @param clusterId The ID of the cluster to retrieve.
    * @return ClusterSlim struct containing the cluster's details.
    */
    function getCluster(uint256 clusterId) external view returns (IIngesterGroupManager.ClusterSlim memory) {
        IIngesterGroupManager.ClusterSlim memory clusterSlim = IIngesterGroupManager.ClusterSlim(
            s.ingesterClusters[clusterId].ingesterAddresses,
            s.ingesterClusters[clusterId].clusterGroupCount,
            s.ingesterClusters[clusterId].clusterRemainingCapacity
        );
      
        return clusterSlim;
    }

    function getIngesterCount() external view returns(uint256) {
        return s.ingesterCount;
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

        string[] memory assignedGroups = s.ingesterClusters[ingester.clusterId].ingesterToAssignedGroups[ingesterAddress];
        IIngesterRegistration.IngesterWithGroups memory ingesterWithAssignedGroups = IIngesterRegistration.IngesterWithGroups(
            ingesterAddress,
            ingester.verified,
            ingester.clusterId,
            assignedGroups
        );
        return ingesterWithAssignedGroups;
    }

    /**
    * @notice Retrieves the list of ingesters for a given controller.
    * @param controllerAddress The address of the controller.
    * @return An array of Ingester structs containing the details of
    */
    function getControllerIngesters(address controllerAddress) public view returns (IIngesterRegistration.Ingester[] memory) {
        return s.controllerToIngesters[controllerAddress];
    }
}
