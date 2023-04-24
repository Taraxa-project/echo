
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../libraries/LibDiamond.sol";
import { LibAppStorage, AppStorage } from  "../libraries/LibAppStorage.sol";
import "../interfaces/IIngesterGroupManager.sol";

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
}
