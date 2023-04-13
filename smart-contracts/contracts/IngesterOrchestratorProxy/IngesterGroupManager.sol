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
    string[] private unAllocatedGroups;

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

    function distributeGroup(string memory _groupUsername) internal {
        uint _clusterId = getMostCapacityCluster();

        uint256 numIngesters = ingesterClusters[_clusterId].ingesterAddresses.length;
        uint256 _maxGroupsPerIngester = 1;
        uint256 numClusterGroups = ingesterClusters[_clusterId].clusterGroupCount;

        //formula to apply a balanced distribution of groups across the ingesters
        if (numClusterGroups > 0) {
            _maxGroupsPerIngester = (numClusterGroups + numIngesters - 1) / numIngesters;
        }

        for (uint256 i = 0; i < numIngesters; ++i) {
            address currentIngesterAddress = ingesterClusters[_clusterId].ingesterAddresses[i];
            IIngesterRegistration.Ingester memory ingester = ingesterProxy.getIngester(currentIngesterAddress);
            uint256 numOfAssignedGroups = ingester.assignedGroups.length;
            uint256 numIngestersPerGroup = groups[_groupUsername].ingesterAddresses.length;
            if (numOfAssignedGroups <= _maxGroupsPerIngester && numIngestersPerGroup < maxNumberIngesterPerGroup) {
                //assign group to ingester
                uint256 assignedGroupsIngesterIndex = ingesterProxy.addAssignedGroupToIngester(currentIngesterAddress, _groupUsername);
                //update _groups storage to include the new ingester and the respective group index in the ingesters storage
                groups[_groupUsername].ingesterAddresses.push(currentIngesterAddress);
                groups[_groupUsername].assignedGroupsIngesterIndex[currentIngesterAddress] = assignedGroupsIngesterIndex;
                //add group to cluster for the respective ingester
                ingesterClusters[_clusterId].ingesterToAssignedGroups[currentIngesterAddress].push(_groupUsername);
                //keep track of where it is stored so it is easy to remove
                groups[_groupUsername].groupClusterIndex = ingesterClusters[_clusterId].ingesterToAssignedGroups[currentIngesterAddress].length - 1;
                ++ingesterClusters[_clusterId].clusterGroupCount;
                
                ingesterClusters[_clusterId].clusterRemainingCapacity = (maxGroupsPerIngester * ingesterClusters[_clusterId].ingesterAddresses.length) - ingesterClusters[_clusterId].clusterGroupCount;

                emit IIngesterGroupManager.GroupDistributed(_clusterId, _groupUsername);
                break;
            }
        }
    }

    function distributeGroupsToCluster(string memory _groupUsername, uint256 _clusterId) internal {

        uint256 numIngesters = ingesterClusters[_clusterId].ingesterAddresses.length;
        uint256 _maxGroupsPerIngester = 1;
        uint256 numClusterGroups = ingesterClusters[_clusterId].clusterGroupCount;

        //formula to apply a balanced distribution of groups across the ingesters
        if (numClusterGroups > 0) {
            _maxGroupsPerIngester = (numClusterGroups + numIngesters - 1) / numIngesters;
        }

        for (uint256 i = 0; i < numIngesters; ++i) {
            address currentIngesterAddress = ingesterClusters[_clusterId].ingesterAddresses[i];
            IIngesterRegistration.Ingester memory ingester = ingesterProxy.getIngester(currentIngesterAddress);
            uint256 numOfAssignedGroups = ingester.assignedGroups.length;
            uint256 numIngestersPerGroup = groups[_groupUsername].ingesterAddresses.length;
            if (numOfAssignedGroups <= _maxGroupsPerIngester && numIngestersPerGroup < maxNumberIngesterPerGroup) {
                //assign group to ingester
                uint256 assignedGroupsIngesterIndex = ingesterProxy.addAssignedGroupToIngester(currentIngesterAddress, _groupUsername);
                //update _groups storage to include the new ingester and the respective group index in the ingesters storage
                groups[_groupUsername].ingesterAddresses.push(currentIngesterAddress);
                groups[_groupUsername].assignedGroupsIngesterIndex[currentIngesterAddress] = assignedGroupsIngesterIndex;
                //add group to cluster for the respective ingester
                ingesterClusters[_clusterId].ingesterToAssignedGroups[currentIngesterAddress].push(_groupUsername);
                //keep track of where it is stored so it is easy to remove
                groups[_groupUsername].groupClusterIndex = ingesterClusters[_clusterId].ingesterToAssignedGroups[currentIngesterAddress].length - 1;
                ++ingesterClusters[_clusterId].clusterGroupCount;
                
                // Convert the scaled saturation ratio to a percentage between 1 and 100
                ingesterClusters[_clusterId].clusterRemainingCapacity = (maxGroupsPerIngester * ingesterClusters[_clusterId].ingesterAddresses.length) - ingesterClusters[_clusterId].clusterGroupCount;
                emit IIngesterGroupManager.GroupDistributed(_clusterId, _groupUsername);
                break;
            }
        }
    }

    function getTotalGroupCapacity() public view returns(uint256) {
        uint256 totalCapacity = 0;
        for (uint256 i = 0; i < clusterIds.length; i++) {
            totalCapacity += ingesterClusters[clusterIds[i]].clusterRemainingCapacity;
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
        return mostAvailableClusterId;
    }

    function distributeGroupPostUnregistration(string[] memory _groups) external onlyIngesterProxy {
        uint _clusterId = getMostCapacityCluster();
        uint256 totalCapacity = ingesterClusters[_clusterId].clusterRemainingCapacity;

        uint256 amountOfGroups = _groups.length;
        if (amountOfGroups > totalCapacity) {
            uint256 _unAllocatableGroups = amountOfGroups - totalCapacity;
            for (uint256 i = 0; i < totalCapacity ; i++) {
                distributeGroupsToCluster(_groups[i], _clusterId);
            }
            for (uint256 i = amountOfGroups - 1; i >= totalCapacity; i--) {
                unAllocatedGroups.push(_groups[i]);
            }
            emit IIngesterGroupManager.AddUnallocatedGroups(unAllocatedGroups);
        } else {
            for (uint256 i = 0; i < amountOfGroups ; i++) {
                distributeGroupsToCluster(_groups[i], _clusterId);
            }
        }
    }

    function distributeGroupsPostRegistration() external onlyIngesterProxy {

        uint _clusterId = getMostCapacityCluster();
        uint256 totalCapacity = ingesterClusters[_clusterId].clusterRemainingCapacity;
        
        uint256 amountUnallocatedGroups = unAllocatedGroups.length;

        if (amountUnallocatedGroups > totalCapacity) {
            uint256 allocatableAmount = amountUnallocatedGroups - totalCapacity;
            for (uint256 i = amountUnallocatedGroups - 1; i >= allocatableAmount ; i--) {
                console.log('allocating unallocated group', i);
                distributeGroupsToCluster(unAllocatedGroups[i], _clusterId);
                unAllocatedGroups.pop();
                emit IIngesterGroupManager.RemoveUnallocatedGroup(unAllocatedGroups[i]);
            }
        } else {
            for (uint256 i = 0; i < amountUnallocatedGroups ; i++) {
                console.log('allocating = all unallocated groups, index is ', i);
                distributeGroupsToCluster(unAllocatedGroups[i], _clusterId);
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

   
    function removeGroup(string calldata _groupUsername) external onlyIngesterProxy {
        require(groups[_groupUsername].isAdded, "Group does not exist.");
        address[] memory ingesterAddresses = groups[_groupUsername].ingesterAddresses;
        removeGroupFromCluster(groups[_groupUsername].clusterId, groups[_groupUsername].groupClusterIndex, _groupUsername, ingesterAddresses);
        removeGroupFromIngesters( _groupUsername, ingesterAddresses); //gas intensive
        groups[_groupUsername].isAdded = false;
        groups[_groupUsername].ingesterAddresses = new address[](0);
        delete groupUsernames[groups[_groupUsername].groupUsernameIndex];
        --groupCount;
        emit IIngesterGroupManager.GroupRemoved(_groupUsername);
    }

    function removeGroupFromCluster(uint256 _clusterId, uint256 _groupClusterIndex, string calldata _groupUsername, address[] memory _ingesterAddresses) internal {
        //Currently there should only be one address per group, this implementation is here to support multiple ingester allocations to one group
        for (uint256 i = 0; i < _ingesterAddresses.length; i++) {
            address _currentIngesterAddress = _ingesterAddresses[i];
            uint256 numAssignedGroups = ingesterClusters[_clusterId].ingesterToAssignedGroups[_currentIngesterAddress].length;
            //Re-adjust the ingesterToAssignedGroups array 
            if (_groupClusterIndex != numAssignedGroups - 1) {
                string memory groupToMove = ingesterClusters[_clusterId].ingesterToAssignedGroups[_currentIngesterAddress][numAssignedGroups - 1];
                ingesterClusters[_clusterId].ingesterToAssignedGroups[_currentIngesterAddress][_groupClusterIndex] = groupToMove;
            }
            ingesterClusters[_clusterId].ingesterAddresses.pop();
            --ingesterClusters[_clusterId].clusterGroupCount;
        }

        //update clusterRemainingCapacity metric on the cluster
        ingesterClusters[_clusterId].clusterRemainingCapacity = (maxGroupsPerIngester * ingesterClusters[_clusterId].ingesterAddresses.length) - ingesterClusters[_clusterId].clusterGroupCount;
        emit IIngesterGroupManager.GroupRemovedFromCluster(_clusterId, _groupUsername);
    }

    function addIngesterToCluster(address _ingesterAddress) external onlyIngesterProxy returns(uint256) {
        uint256 clusterId = 0;
        if (clusterIds.length == 0) {
            clusterIds.push(clusterId);
        } else {
            clusterId = getAvailableCluster();
        }
        
        ingesterClusters[clusterId].ingesterAddresses.push(_ingesterAddress);
        ingesterClusters[clusterId].clusterRemainingCapacity = (maxGroupsPerIngester * ingesterClusters[clusterId].ingesterAddresses.length) - ingesterClusters[clusterId].clusterGroupCount;
       
        emit IIngesterGroupManager.IngesterAddedToCluster(_ingesterAddress, clusterId);
        return clusterId;
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

    function removeIngesterFromCluster(address _ingesterAddress, uint256 _clusterId) external onlyIngesterProxy {
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
                
                //remove all assignedGroups from ingester within the cluster
                ingesterClusters[_clusterId].clusterGroupCount -= ingesterClusters[_clusterId].ingesterToAssignedGroups[_ingesterAddress].length;
                ingesterClusters[_clusterId].ingesterToAssignedGroups[_ingesterAddress] = new string[](0);

                //re-calculate cluster remaining capacity
                ingesterClusters[_clusterId].clusterRemainingCapacity = (maxGroupsPerIngester * ingesterClusters[_clusterId].ingesterAddresses.length) - ingesterClusters[_clusterId].clusterGroupCount;
                break;
            }
        }
    }

    function removeGroupFromIngesters(string memory _groupUsername, address[] memory _ingesterAddresses) internal  {
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

    function removeIngesterFromGroups(string[] memory _groups, address _ingesterAddress) external onlyIngesterProxy {
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

    function setIngesterProxy(address _ingesterProxyAddress) external onlyAdmin {
        ingesterProxyAddress = _ingesterProxyAddress;
        ingesterProxy = IngesterProxy(_ingesterProxyAddress);
    }

    function getClusters() external view returns (uint256[] memory){
        return clusterIds;
    }

    function getCluster(uint256 _clusterId) external view returns (IIngesterGroupManager.ClusterSlim memory) {
        IIngesterGroupManager.ClusterSlim memory clusterSlim = IIngesterGroupManager.ClusterSlim(
            ingesterClusters[_clusterId].ingesterAddresses,
            ingesterClusters[_clusterId].clusterGroupCount,
            ingesterClusters[_clusterId].clusterRemainingCapacity
        );
      
        return clusterSlim;
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

    function getUnallocatedGroups() external view returns(string[] memory) {
        return unAllocatedGroups;
    }

}
