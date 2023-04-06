// SPDX-License-Identifier: MIT
pragma solidity 0.8.14;

import "@openzeppelin/contracts/access/AccessControlEnumerable.sol";
import "../interfaces/IngesterOrchestratorProxy/IIngesterGroupManager.sol";
import "../interfaces/IngesterOrchestratorProxy/IIngesterRegistration.sol";
import "./IngesterProxy.sol";
import "hardhat/console.sol";

contract IngesterGroupManager is AccessControlEnumerable, IIngesterGroupManager {

    address public ingesterProxyAddress;
    IngesterProxy public ingesterProxy;
    uint256 private maxClusterSize; // 5
    uint256 private maxGroupsPerIngester; // 300
    uint256 private maxNumberIngesterPerGroup;
    mapping(uint => Cluster) private ingesterClusters;
    uint256[] private clusterIds;
    mapping(string => Group) private groups;
    string[] private groupUsernames;
    uint256 private groupCount;
    string[] unAllocatedGroups;

    //TODO: maxNumberIngesterPerGroup for customization of group replication across ingesters
    constructor(uint256 _maxClusterSize, uint256 _maxGroupsPerIngester, uint256 _maxNumberIngesterPerGroup) {
        maxClusterSize = _maxClusterSize;
        maxGroupsPerIngester = _maxGroupsPerIngester;
        maxNumberIngesterPerGroup = _maxNumberIngesterPerGroup;
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    modifier onlyIngesterProxy() {
        require(msg.sender == ingesterProxyAddress, "Caller is not the IngesterProxy");
        _;
    }

    modifier onlyAdmin() {
        require(hasRole(DEFAULT_ADMIN_ROLE, msg.sender), "Only admin can perform this action.");
        _;
    }

    function setIngesterProxy(address _ingesterProxyAddress) external onlyAdmin {
        ingesterProxyAddress = _ingesterProxyAddress;
        ingesterProxy = IngesterProxy(_ingesterProxyAddress);
    }

    function getClusters() external view returns (uint256[] memory){
        return clusterIds;
    }

    function getCluster(uint256 _clusterId) external view returns (IIngesterGroupManager.Cluster memory) {
        return ingesterClusters[_clusterId];
    }

    function distributeGroup(string memory _groupUsername) internal {
        uint clusterId = getMostCapacityCluster();

        //make sure it rounds up in this operation to allow for adding new groups when remainder > 0
        uint256 numIngesters = ingesterClusters[clusterId].ingesterAddresses.length;
        uint256 _maxGroupsPerIngester = 1;

        uint256 numClusterGroups = ingesterClusters[clusterId].clusterGroups.length;

        if (numClusterGroups > 0) {
            _maxGroupsPerIngester = (numClusterGroups + numIngesters - 1) / numIngesters;
        }
        // todo need to add ingesterClusters[clusterId].clusterGroups check for 5 * 300 groups, can't go over that
        // todo implement also that 5 * 300 * maxGroupsPerIngester in case of replication

        for (uint256 i = 0; i < numIngesters; ++i) {
            address currentIngesterAddress = ingesterClusters[clusterId].ingesterAddresses[i];
            IIngesterRegistration.Ingester memory ingester = ingesterProxy.getIngester(currentIngesterAddress);
            uint256 numOfAssignedGroups = ingester.assignedGroups.length;
            uint256 numIngestersPerGroup = groups[_groupUsername].ingesterAddresses.length;

            if (numOfAssignedGroups <= _maxGroupsPerIngester && numIngestersPerGroup < maxNumberIngesterPerGroup) {
                //assign group to ingester
                uint256 assignedGroupsIngesterIndex = ingesterProxy.addAssignedGroupToIngester(currentIngesterAddress, _groupUsername);
                //update _groups storage to include the new ingester and the respective group index in the ingesters storage
                groups[_groupUsername].ingesterAddresses.push(currentIngesterAddress);
                groups[_groupUsername].assignedGroupsIngesterIndex[currentIngesterAddress] = assignedGroupsIngesterIndex;
                ingesterClusters[clusterId].clusterGroups.push(_groupUsername);
                
                // Convert the scaled saturation ratio to a percentage between 1 and 100
                ingesterClusters[clusterId].clusterRemainingCapacity = (maxGroupsPerIngester * ingesterClusters[clusterId].ingesterAddresses.length) - ingesterClusters[clusterId].clusterGroups.length;
                break;
            }
        }
    }

    function getTotalGroupCapacity() internal returns(uint256) {
        uint256 totalCapacity = 0;
        for (uint256 i = 0; i < clusterIds.length; i++) {
            totalCapacity = totalCapacity + ingesterClusters[clusterIds[i]].clusterRemainingCapacity;
        }
        return totalCapacity;
    }

    function getMostCapacityCluster() internal returns(uint256) {
        //need to calculate this for an adaptive metric depending on group size
        uint256 mostAvailableGroups = 0;
        uint256 mostAvailableClusterId = 0;
        for (uint256 i = 0; i < clusterIds.length; i++) {
            if (ingesterClusters[clusterIds[i]].clusterRemainingCapacity > mostAvailableGroups) {
                mostAvailableGroups = ingesterClusters[clusterIds[i]].clusterRemainingCapacity;
                mostAvailableClusterId = clusterIds[i];
            }
        }
        require(mostAvailableGroups > 0, "No more ingesters available to add groups to");
        // console.log("chose most available cluster", mostAvailableClusterId);
        // console.log("with amount of groups left:", mostAvailableGroups);
        return mostAvailableClusterId;
    }

    function distributeGroupPostUnregistration(string[] memory _groups) external onlyIngesterProxy {
        //first check if amount of groups can be allocated according to constraints
        // if they can't, then add to unallocated groups storage - this can be allocated about registration of a new ingester
        //if they are not breaking constraints
        // - find way to assign a batch of groups to the ingesters and to the respective clusters
        // group storage would still have to be updated one by one
        uint256 totalCapacity = getTotalGroupCapacity();
        uint256 amountOfGroups = _groups.length;
        console.log("amount of groups to allocate", totalCapacity);
        console.log("total capacity", totalCapacity);
        if (amountOfGroups > totalCapacity) {
            uint256 unAllocatableGroups = amountOfGroups - totalCapacity;
            console.log("too many groups, will allocate", totalCapacity);
            console.log("number of unallocated groups", unAllocatableGroups);
            for (uint256 i = 0; i <= totalCapacity; i++) {
                distributeGroup(_groups[i]);
            }
            for (uint256 i = amountOfGroups; i > totalCapacity; i--) {
                unAllocatedGroups.push(_groups[i]);
            }
        } else {
            console.log("have enough space, allocating groups to other ingester");
            for (uint256 i = 0; i <= amountOfGroups ; i++) {
                distributeGroup(_groups[i]);
            }
        }
    }

    function addGroup(string calldata groupUsername) external onlyIngesterProxy {
        require(!groups[groupUsername].isAdded, "Group already exists.");
        groupUsernames.push(groupUsername);
        groups[groupUsername].isAdded = true;
        groups[groupUsername].groupUsernameIndex = groupUsernames.length -1;
        ++groupCount;
        distributeGroup(groupUsername);
        emit IIngesterGroupManager.GroupAdded(groupUsername);
    }

   
    function removeGroup(string calldata groupUsername) external onlyIngesterProxy {
        require(groups[groupUsername].isAdded, "Group does not exist.");
        address[] memory ingesterAddresses = groups[groupUsername].ingesterAddresses;
        removingGroupFromIngesters(groupUsername, ingesterAddresses); //gas intensive
        groups[groupUsername].isAdded = false;
        groups[groupUsername].ingesterAddresses = new address[](0);
        delete groupUsernames[groups[groupUsername].groupUsernameIndex];
        --groupCount;
        emit IIngesterGroupManager.GroupRemoved(groupUsername);
    }

    function addIngesterToCluster(address _ingesterAddress) external onlyIngesterProxy returns(uint256) {
        uint256 clusterId = 0;
        if (clusterIds.length == 0) {
            clusterIds.push(clusterId);
        } else {
            clusterId = getAvailableCluster();
        }
        ingesterClusters[clusterId].ingesterAddresses.push(_ingesterAddress);
        ingesterClusters[clusterId].clusterRemainingCapacity = (maxGroupsPerIngester * ingesterClusters[clusterId].ingesterAddresses.length) - ingesterClusters[clusterId].clusterGroups.length;
        emit IIngesterGroupManager.IngesterAddedToCluster(_ingesterAddress, clusterId);
        return clusterId;
    }

    function removeIngesterFromCluster(address _ingesterAddress, uint256 _clusterId, string[] memory _assignedGroups) external onlyIngesterProxy {
        uint256 numIngesters = ingesterClusters[_clusterId].ingesterAddresses.length;
        uint256 ingesterIndexToRemove = 0;
        for (uint256 i = 0; i < numIngesters; i++) {
            if (ingesterClusters[_clusterId].ingesterAddresses[i] == _ingesterAddress) {
                ingesterIndexToRemove = i;
                //Re-adjust the ingesterAddresses array 
                if (i != numIngesters - 1) {
                    address ingesterAddressToMove = ingesterClusters[_clusterId].ingesterAddresses[numIngesters - 1];
                    ingesterClusters[_clusterId].ingesterAddresses[i] = ingesterAddressToMove;
                }
                ingesterClusters[_clusterId].ingesterAddresses.pop();
                //re-calculate cluster remaining capacity
                ingesterClusters[_clusterId].clusterRemainingCapacity = (maxGroupsPerIngester * ingesterClusters[_clusterId].ingesterAddresses.length) - ingesterClusters[_clusterId].clusterGroups.length;
                break;
            }
        }
    }

    function getAvailableCluster() internal returns (uint256) {
        uint256 availableCluster = 0;
        bool foundAvailableCluster = false;
        for (uint256 i = 0; i < clusterIds.length; i++) {
            if (ingesterClusters[clusterIds[i]].ingesterAddresses.length < maxClusterSize) {
                availableCluster = clusterIds[i]; 
                foundAvailableCluster = true;
            }
        }
        if (foundAvailableCluster != true) {
            //create new cluster
            availableCluster = clusterIds.length;
            clusterIds.push(availableCluster);
            return availableCluster;
        } else {
            return availableCluster;
        }
    }

    function removingGroupFromIngesters(string memory _groupUsername, address[] memory _ingesterAddresses) internal  {
        for (uint256 i = 0; i < _ingesterAddresses.length; ++i) {
            address _currentIngesterAddress = _ingesterAddresses[i];
            IIngesterRegistration.Ingester memory ingester = ingesterProxy.getIngester(_currentIngesterAddress);
            
            uint256 assignedGroupsIngesterIndex = groups[_groupUsername].assignedGroupsIngesterIndex[_currentIngesterAddress];

            require(assignedGroupsIngesterIndex < ingester.assignedGroups.length, "Index out of bounds");

            string memory groupToMove = ingester.assignedGroups[ingester.assignedGroups.length - 1];

            ingesterProxy.moveIngesterAssignedGroup(_currentIngesterAddress, assignedGroupsIngesterIndex);

            //update move grouped new index to the respective groups storage
            groups[groupToMove].assignedGroupsIngesterIndex[_currentIngesterAddress] = assignedGroupsIngesterIndex;

            emit IIngesterGroupManager.GroupRemovedFromIngester(_currentIngesterAddress, _groupUsername);
        }
    }

    function removeIngesterFromGroups(string[] memory _groups, address _ingesterAddress) external {
        for (uint256 i = 0; i < _groups.length; ++i) {
            // These arrays are capped by the _maxNumberIngesterPerGroup
            uint256 amountOfIngestersPerGroup = groups[_groups[i]].ingesterAddresses.length;
            for (uint256 j = 0; j < amountOfIngestersPerGroup; j++) {
                if(groups[_groups[i]].ingesterAddresses[j] == _ingesterAddress ) {
                    //delete ingesterAddress from _groups and readjust array length so _maxNumberIngesterPerGroup check remains truthful
                    for (uint256 z = j; z < amountOfIngestersPerGroup - 1; ++z) {
                        groups[_groups[i]].ingesterAddresses[z] = groups[_groups[i]].ingesterAddresses[z+1];
                    }
                    groups[_groups[i]].ingesterAddresses.pop();
                    emit IIngesterGroupManager.IngesterRemovedFromGroup(_ingesterAddress, _groups[i]);
                    break;
                }
            }
        }
    }

    function getGroup(string calldata groupUsername) external view returns (IIngesterGroupManager.GroupToIngester memory) {
        IIngesterGroupManager.GroupToIngester memory group = IIngesterGroupManager.GroupToIngester(
            groups[groupUsername].isAdded,
            groups[groupUsername].clusterId,
            groups[groupUsername].ingesterAddresses, 
            groups[groupUsername].groupUsernameIndex
        );
        return group;
    }

    function getGroupCount() external view returns (uint256) {
        return groupCount;
    }

    function getGroupUsernameByIndex(uint256 groupIndex) external view returns (string memory) {
        return groupUsernames[groupIndex];
    }

    

    function updateIngesterProxy(address newIngesterProxy) external onlyAdmin {
        ingesterProxyAddress = newIngesterProxy;
    }

    function getMaxClusterSize() external view returns (uint256) {
        return maxClusterSize;
    }

    function getMaxGroupsPerIngester() external view returns (uint256) {
        return maxGroupsPerIngester;
    }

    function getMaxNumberIngesterPerGroup() external view returns (uint256) {
        return maxNumberIngesterPerGroup;
    }

    function setMaxClusterSize(uint256 _maxClusterSize) external onlyIngesterProxy {
        maxClusterSize = _maxClusterSize;
    }

    function setMaxGroupsPerIngester(uint256 _maxGroupsPerIngester) external onlyIngesterProxy {
        maxGroupsPerIngester = _maxGroupsPerIngester;
    }

    function setMaxNumberIngesterPerGroup(uint256 _maxNumberIngesterPerGroup) external onlyIngesterProxy {
        maxNumberIngesterPerGroup = _maxNumberIngesterPerGroup;
        emit IIngesterGroupManager.SetNewMaxIngesterPerGroup(_maxNumberIngesterPerGroup);
    }

}
