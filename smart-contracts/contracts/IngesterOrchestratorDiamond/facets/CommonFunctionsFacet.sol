
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../libraries/LibDiamond.sol";
import { LibAppStorage, AppStorage } from  "../libraries/LibAppStorage.sol";
import "../interfaces/IIngesterGroupManager.sol";
import "../interfaces/IIngesterRegistration.sol";

contract CommonFunctionsFacet {
    AppStorage internal s;
    
    function getUnallocatedGroups() external view returns(string[] memory) {
        return LibAppStorage.getUnallocatedGroups();
    }

    function getClusters() external view returns (uint256[] memory){
        return s.clusterIds;
    }

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

    function getIngester(address ingesterAddress) external view returns (IIngesterRegistration.Ingester memory) {
        require(s.ingesterToController[ingesterAddress].controllerAddress != address(0), "Ingester does not exist.");
        address controller = s.ingesterToController[ingesterAddress].controllerAddress;
        uint ingesterIndex = s.ingesterToController[ingesterAddress].ingesterIndex;

        return s.controllerToIngesters[controller][ingesterIndex];
    }

    function getIngesters() external view returns (address[] memory) {
        return LibAppStorage.getIngesters();
    }

    function getIngesterWithGroups(address ingesterAddress) external view returns (IIngesterRegistration.IngesterWithGroups memory) {
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
}
