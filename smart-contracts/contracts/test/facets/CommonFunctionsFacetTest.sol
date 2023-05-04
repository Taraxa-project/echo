


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../../libraries/LibDiamond.sol";
import { LibAppStorageTest, AppStorageTest } from  "../libraries/LibAppStorageUpgradeTest.sol";
import "../../interfaces/IIngesterGroupManager.sol";
import "../../interfaces/IIngesterRegistration.sol";

contract CommonFunctionsFacetTest {
    AppStorageTest internal s;
    
    function getUnallocatedGroups() external view returns(string[] memory) {
        return LibAppStorageTest.getUnallocatedGroups();
    }

    function setTestProperty(bool testProperty) external {
        s.newTestProperty = testProperty;
    }

    function getTestProperty() external view returns(bool) {
        return LibAppStorageTest.getTestProperty();
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

    function getIngester(address ingesterAddress) public view virtual returns (IIngesterRegistration.Ingester memory) {
        require(s.ingesterToController[ingesterAddress].controllerAddress != address(0), "Ingester does not exist.");
        address controller = s.ingesterToController[ingesterAddress].controllerAddress;
        uint ingesterIndex = s.ingesterToController[ingesterAddress].ingesterIndex;
        return s.controllerToIngesters[controller][ingesterIndex];
    }

    function getIngesters() public view returns (address[] memory) {
        return LibAppStorageTest.getIngesters();
    }

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

    function divideAndRoundUp(uint256 numerator, uint256 denominator) public pure returns (uint256) {
        require(denominator != 0, "Division by zero");
        uint256 result = numerator / denominator;
        uint256 remainder = numerator % denominator;

        // Check if the remainder is at least half of the denominator to decide whether to round up
        if (remainder * 2 >= denominator) {
            result += 1;
        }

        return result;
    }
}
