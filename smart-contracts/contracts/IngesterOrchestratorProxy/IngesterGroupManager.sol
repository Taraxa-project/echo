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
    uint256 private _maxClusterSize; // 5
    uint256 private _maxGroupsPerIngester; // 300
    uint256 private _maxNumberIngesterPerGroup;
    mapping(uint => Cluster) private _ingesterClusters;
    uint256[] private _clusterIds;
    mapping(string => Group) private _groups;
    string[] private _groupUsernames;
    uint256 private _groupCount;
    string[] private _unAllocatedGroups;

    //TODO: maxNumberIngesterPerGroup for customization of group replication across ingesters
    constructor(uint256 maxClusterSize, uint256 maxGroupsPerIngester, uint256 maxNumberIngesterPerGroup) {
        _maxClusterSize = maxClusterSize;
        _maxGroupsPerIngester = maxGroupsPerIngester;
        _maxNumberIngesterPerGroup = maxNumberIngesterPerGroup;
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
    
    /**
     * @dev Distributes a group to the most available capacity cluster.
     * @param groupUsername The group username to distribute.
     */
    function distributeGroup(string memory groupUsername) internal {
        uint clusterId = getMostCapacityCluster();

        uint256 numIngesters = _ingesterClusters[clusterId].ingesterAddresses.length;
        uint256 maxGroupsPerIngester = 1;
        uint256 numClusterGroups = _ingesterClusters[clusterId].clusterGroupCount;

        //formula to apply a balanced distribution of groups across the ingesters
        if (numClusterGroups > 0) {
            maxGroupsPerIngester = (numClusterGroups + numIngesters - 1) / numIngesters;
        }

        for (uint256 i = 0; i < numIngesters; ++i) {
            address currentIngesterAddress = _ingesterClusters[clusterId].ingesterAddresses[i];
            if(_groups[groupUsername].ingesterToGroup[currentIngesterAddress].isAdded) {
                continue;
            }
            IIngesterRegistration.Ingester memory ingester = ingesterProxy.getIngester(currentIngesterAddress);
            uint256 numOfAssignedGroups = ingester.assignedGroups.length;
            uint256 numIngestersPerGroup = _groups[groupUsername].ingesterAddresses.length;
            if (numOfAssignedGroups <= maxGroupsPerIngester && numIngestersPerGroup < _maxNumberIngesterPerGroup) {
                //assign group to ingester
                uint256 assignedGroupsIngesterIndex = ingesterProxy.addAssignedGroupToIngester(currentIngesterAddress, groupUsername);
                //update __groups storage to include the new ingester and the respective group index in the ingesters storage
                _groups[groupUsername].ingesterAddresses.push(currentIngesterAddress);
                _groups[groupUsername].ingesterToGroup[currentIngesterAddress].assignedGroupsIngesterIndex = assignedGroupsIngesterIndex;
                //add group to cluster for the respective ingester
                _ingesterClusters[clusterId].ingesterToAssignedGroups[currentIngesterAddress].push(groupUsername);
                //keep track of where it is stored so it is easy to remove
                _groups[groupUsername].ingesterToGroup[currentIngesterAddress].groupClusterIngesterIndex = _ingesterClusters[clusterId].ingesterToAssignedGroups[currentIngesterAddress].length - 1;
                ++_ingesterClusters[clusterId].clusterGroupCount;

                // Re=calculate clusterRemainingCapacity
                _ingesterClusters[clusterId].clusterRemainingCapacity = (_maxGroupsPerIngester * _ingesterClusters[clusterId].ingesterAddresses.length) - _ingesterClusters[clusterId].clusterGroupCount;

                emit IIngesterGroupManager.GroupDistributed(clusterId, groupUsername);
                //if there is replication, then keep assigning to the remining cluster, otherwise break
                if ( i >= _maxNumberIngesterPerGroup - 1) {
                    break;
                }
            }
        }
    }

    /**
     * @dev Distributes groups to the specified ingester address.
     * @param ingesterAddress The ingester address to distribute groups to.
     */
    function distributeGroups(address ingesterAddress) external onlyIngesterProxy {
        uint numUnallocatedGroups = _unAllocatedGroups.length;
        IIngesterRegistration.Ingester memory ingester = ingesterProxy.getIngester(ingesterAddress);
        uint256 clusterId = ingester.clusterId;
        //prioritise allocation groups
        if (numUnallocatedGroups > 0) {
            uint256 clusterCapacity = _ingesterClusters[clusterId].clusterRemainingCapacity;

            if (numUnallocatedGroups > clusterCapacity) {
                uint256 allocatableAmount = numUnallocatedGroups - clusterCapacity;
                while (_unAllocatedGroups.length > allocatableAmount) {
                    uint256 i = _unAllocatedGroups.length - 1;
                    distributeGroupsToCluster(_unAllocatedGroups[i], clusterId);
                    emit IIngesterGroupManager.RemoveUnallocatedGroup(_unAllocatedGroups[i]);
                    _unAllocatedGroups.pop();
                }
            } else {
                while (_unAllocatedGroups.length > 0) {
                    uint256 i = _unAllocatedGroups.length - 1;
                    distributeGroupsToCluster(_unAllocatedGroups[i], clusterId);
                    emit IIngesterGroupManager.RemoveUnallocatedGroup(_unAllocatedGroups[i]);
                    _unAllocatedGroups.pop();
                }
            }

        } else {
            if (_maxNumberIngesterPerGroup > 1) {
                //accounting for group replication scenario, simply assign present groups to cluster
                address ingesterToCopyGroupsFrom = _ingesterClusters[clusterId].ingesterAddresses[0];
                string[] memory groupsToAllocate = _ingesterClusters[clusterId].ingesterToAssignedGroups[ingesterToCopyGroupsFrom];
                console.log('groupsToAllocate upon distribute groups after registration', groupsToAllocate.length);
                for (uint i = 0; i < groupsToAllocate.length; i++) {
                    distributeGroupsToCluster(groupsToAllocate[i], clusterId);
                }
            } else {
                revert("No more groups to allocate.");
            }
        }
    }

    /**
     * @dev Distributes a group to the specified cluster.
     * @param groupUsername The group username to distribute.
     * @param clusterId The cluster ID to distribute the group to.
     */
    function distributeGroupsToCluster(string memory groupUsername, uint256 clusterId) internal {

        uint256 numIngesters = _ingesterClusters[clusterId].ingesterAddresses.length;
        uint256 maxGroupsPerIngester = 1;
        uint256 numClusterGroups = _ingesterClusters[clusterId].clusterGroupCount;

        //formula to apply a balanced distribution of groups across the ingesters
        if (numClusterGroups > 0) {
            maxGroupsPerIngester = (numClusterGroups + numIngesters - 1) / numIngesters;
        }

        for (uint256 i = 0; i < numIngesters; ++i) {
            address currentIngesterAddress = _ingesterClusters[clusterId].ingesterAddresses[i];
            if(_groups[groupUsername].ingesterToGroup[currentIngesterAddress].isAdded) {
                continue;
            }
            IIngesterRegistration.Ingester memory ingester = ingesterProxy.getIngester(currentIngesterAddress);
            uint256 numOfAssignedGroups = ingester.assignedGroups.length;
            uint256 numIngestersPerGroup = _groups[groupUsername].ingesterAddresses.length;
            if (numOfAssignedGroups <= maxGroupsPerIngester && numIngestersPerGroup < _maxNumberIngesterPerGroup) {
                //assign group to ingester
                uint256 assignedGroupsIngesterIndex = ingesterProxy.addAssignedGroupToIngester(currentIngesterAddress, groupUsername);
                //update _groups storage to include the new ingester and the respective group index in the ingesters storage
                _groups[groupUsername].ingesterAddresses.push(currentIngesterAddress);
                _groups[groupUsername].ingesterToGroup[currentIngesterAddress].assignedGroupsIngesterIndex = assignedGroupsIngesterIndex;
                //add group to cluster for the respective ingester
                _ingesterClusters[clusterId].ingesterToAssignedGroups[currentIngesterAddress].push(groupUsername);
                //keep track of where it is stored so it is easy to remove
                _groups[groupUsername].ingesterToGroup[currentIngesterAddress].groupClusterIngesterIndex = _ingesterClusters[clusterId].ingesterToAssignedGroups[currentIngesterAddress].length - 1;
                ++_ingesterClusters[clusterId].clusterGroupCount;
                
                // Re-calculate clusterRemainingCapacity
                require((_maxGroupsPerIngester * _ingesterClusters[clusterId].ingesterAddresses.length) >= _ingesterClusters[clusterId].clusterGroupCount, "More groups in cluster than cluster constraints");
                _ingesterClusters[clusterId].clusterRemainingCapacity = (_maxGroupsPerIngester * _ingesterClusters[clusterId].ingesterAddresses.length) - _ingesterClusters[clusterId].clusterGroupCount;
                emit IIngesterGroupManager.GroupDistributed(clusterId, groupUsername);
                if ( i >= _maxNumberIngesterPerGroup - 1) {
                    break;
                }
            }
        }
    }

    /**
     * @dev Returns the total group capacity across all clusters.
     * @return The total group capacity.
     */
    function getTotalGroupCapacity() public view returns(uint256) {
        uint256 totalCapacity = 0;
        for (uint256 i = 0; i < _clusterIds.length; i++) {
            totalCapacity += _ingesterClusters[_clusterIds[i]].clusterRemainingCapacity;
        }
        return totalCapacity;
    }

    /**
     * @dev Returns the ID of the cluster with the most capacity available.
     * @return The ID of the cluster with the most capacity.
     */
    function getMostCapacityCluster() internal view returns(uint256) {
        //need to calculate this for an adaptive metric depending on group size
        uint256 mostAvailableGroups = 0;
        uint256 mostAvailableClusterId = 0;
        for (uint256 i = 0; i < _clusterIds.length; i++) {
            if (_ingesterClusters[_clusterIds[i]].clusterRemainingCapacity > mostAvailableGroups) {
                mostAvailableGroups = _ingesterClusters[_clusterIds[i]].clusterRemainingCapacity;
                mostAvailableClusterId = _clusterIds[i];
            }
        }
        require(mostAvailableGroups > 0, "No more ingesters available to add groups to");
        return mostAvailableClusterId;
    }

    /**
    * @notice Redistributes groups among clusters after an ingester unregistration.
    * @param groups An array of group usernames to be redistributed.
    * @param clusterId The ID of the cluster to redistribute the groups to.
    */
    function distributeGroupPostUnregistration(string[] memory groups, uint256 clusterId) external onlyIngesterProxy {
        if (_maxNumberIngesterPerGroup > 1){ 
            //if cluster is completely empty, then add groups as unAllocatedGroups
            if (_ingesterClusters[clusterId].ingesterAddresses.length == 0) {
                uint256 numGroups = groups.length;
                for (uint256 i = 0; i < numGroups; i++) {
                    _unAllocatedGroups.push(groups[i]);
                }
                emit IIngesterGroupManager.AddUnallocatedGroups(_unAllocatedGroups);
            } 
            //otherwise don't do anything since there is replication of groups
        } else {
            uint mostCapacityClusterId = getMostCapacityCluster();
            uint256 totalCapacity = _ingesterClusters[mostCapacityClusterId].clusterRemainingCapacity;

            uint256 amountOfGroups = groups.length;
            if (amountOfGroups > totalCapacity) {
                for (uint256 i = 0; i < totalCapacity ; i++) {
                    distributeGroupsToCluster(groups[i], mostCapacityClusterId);
                }
                for (uint256 i = amountOfGroups - 1; i >= totalCapacity; i--) {
                    _unAllocatedGroups.push(groups[i]);
                }
                emit IIngesterGroupManager.AddUnallocatedGroups(_unAllocatedGroups);
            } else {
                for (uint256 i = 0; i < amountOfGroups ; i++) {
                    distributeGroupsToCluster(groups[i], mostCapacityClusterId);
                }
            }
        }

    }

    /**
    * @notice Adds a new group to the system and distributes it among the clusters.
    * @param groupUsername The username of the group to be added.
    */
    function addGroup(string calldata groupUsername) external onlyIngesterProxy {
        require(!_groups[groupUsername].isAdded, "Group already exists.");
        _groupUsernames.push(groupUsername);
        _groups[groupUsername].isAdded = true;
        _groups[groupUsername].groupUsernameIndex = _groupUsernames.length -1;
        ++_groupCount;
        distributeGroup(groupUsername);
        emit IIngesterGroupManager.GroupAdded(groupUsername);
    }

    /**
    * @notice Removes a group from the system.
    * @param groupUsername The username of the group to be removed.
    */
    function removeGroup(string calldata groupUsername) external onlyIngesterProxy {
        require(_groups[groupUsername].isAdded, "Group does not exist.");
        address[] memory ingesterAddresses = _groups[groupUsername].ingesterAddresses;
        removeGroupFromCluster(_groups[groupUsername].clusterId, groupUsername, ingesterAddresses);
        removeGroupFromIngesters( groupUsername, ingesterAddresses); //gas intensive
        delete _groupUsernames[_groups[groupUsername].groupUsernameIndex];
        delete _groups[groupUsername];
        --_groupCount;
        emit IIngesterGroupManager.GroupRemoved(groupUsername);
    }

    /**
     * @dev Removes a group from the specified cluster and its associated ingester addresses.
     * @param clusterId The cluster ID to remove the group from.
     * @param groupUsername The group username to remove.
     * @param ingesterAddresses The array of ingester addresses associated with the group.
     */
    function removeGroupFromCluster(uint256 clusterId, string calldata groupUsername, address[] memory ingesterAddresses) internal {
        //Currently there should only be one address per group, this implementation is here to support multiple ingester allocations to one group
        for (uint256 i = 0; i < ingesterAddresses.length; i++) {
            address _currentIngesterAddress = ingesterAddresses[i];
            uint256 numAssignedGroups = _ingesterClusters[clusterId].ingesterToAssignedGroups[_currentIngesterAddress].length;
            uint256 groupClusterIndex = _groups[groupUsername].ingesterToGroup[_currentIngesterAddress].groupClusterIngesterIndex;
            //Re-adjust the ingesterToAssignedGroups array 
            if (groupClusterIndex != numAssignedGroups - 1) {
                string memory groupToMove = _ingesterClusters[clusterId].ingesterToAssignedGroups[_currentIngesterAddress][numAssignedGroups - 1];
                _ingesterClusters[clusterId].ingesterToAssignedGroups[_currentIngesterAddress][groupClusterIndex] = groupToMove;
            }
            _ingesterClusters[clusterId].ingesterAddresses.pop();
            --_ingesterClusters[clusterId].clusterGroupCount;
        }

        //update clusterRemainingCapacity metric on the cluster
        _ingesterClusters[clusterId].clusterRemainingCapacity = (_maxGroupsPerIngester * _ingesterClusters[clusterId].ingesterAddresses.length) - _ingesterClusters[clusterId].clusterGroupCount;
        emit IIngesterGroupManager.GroupRemovedFromCluster(clusterId, groupUsername);
    }

    /**
    * @notice Adds an ingester to a cluster.
    * @param ingesterAddress The address of the ingester to be added.
    * @param controllerAddress The address of the controller responsible for the ingester.
    * @return The ID of the cluster the ingester was added to.
    */
    function addIngesterToCluster(address ingesterAddress, address controllerAddress) external onlyIngesterProxy returns(uint256) {
        uint256 clusterId = 0;
        if (_clusterIds.length == 0) {
            _clusterIds.push(clusterId);
        } else {
            clusterId = getAvailableCluster(ingesterAddress, controllerAddress);
        }
        
        _ingesterClusters[clusterId].ingesterAddresses.push(ingesterAddress);
        _ingesterClusters[clusterId].clusterRemainingCapacity = (_maxGroupsPerIngester * _ingesterClusters[clusterId].ingesterAddresses.length) - _ingesterClusters[clusterId].clusterGroupCount;
       
        emit IIngesterGroupManager.IngesterAddedToCluster(ingesterAddress, clusterId);
        return clusterId;
    }

    /**
     * @dev Returns the available cluster for a given ingester and controller address.
     * @param ingesterAddress The address of the ingester.
     * @param controllerAddress The address of the controller.
     * @return The available cluster ID.
     */
    function getAvailableCluster(address ingesterAddress, address controllerAddress) internal returns (uint256) {
        uint256 availableCluster = 0;
        bool foundAvailableCluster = false;
        uint256 numClusters = _clusterIds.length;

        //if there are unallocated groups, create new cluster
        if (_unAllocatedGroups.length > 0) {
            _clusterIds.push(numClusters);
            return numClusters;
        }

        //otherwise go through the existing clusters and get the first available one
        for (uint256 i = 0; i < numClusters; i++) {
            if (_ingesterClusters[_clusterIds[i]].ingesterAddresses.length < _maxClusterSize) {
                availableCluster = _clusterIds[i]; 
                foundAvailableCluster = true;

                //If there is Duplication.
                //Restrict more than one controller wallet owning one ingester per cluster
                if (_maxNumberIngesterPerGroup > 1) {
                    IIngesterRegistration.Ingester[] memory controllerIngesters = ingesterProxy.getControllerIngesters(controllerAddress);

                    for (uint j = 0; j < _ingesterClusters[availableCluster].ingesterAddresses.length; j++) {
                        for (uint k = 0; k < controllerIngesters.length; k++) {
                            //controller ingester addresses match ingesterAddresses within the cluster and it's not the current ingester we are trying to assign
                            //continue looking for another cluster
                            if (_ingesterClusters[availableCluster].ingesterAddresses[j] == controllerIngesters[k].ingesterAddress && _ingesterClusters[availableCluster].ingesterAddresses[j] != ingesterAddress) {
                                foundAvailableCluster = false;
                            }
                        }
                    }
                } else {
                    break;
                }
            }
        }
        if (foundAvailableCluster != true) {
            //create new cluster
            availableCluster = numClusters;
            _clusterIds.push(availableCluster);
            return availableCluster;
        } else {
            return availableCluster;
        }
    }

    /**
     * @dev Removes the specified cluster from the list of clusters.
     * @param clusterId The cluster ID to remove.
     */
    function removeCluster(uint256 clusterId) internal {
        uint256 clusterIndex = _ingesterClusters[clusterId].clusterIndex;
        uint256 numClusters = _clusterIds.length;
        if (clusterIndex != numClusters - 1) {
            uint256 clusterToMove = _clusterIds[numClusters - 1];
            _clusterIds[clusterIndex] = clusterToMove;
        }
        _clusterIds.pop();
    }

    /**
    * @notice Removes an ingester from a cluster.
    * @param ingesterAddress The address of the ingester to be removed.
    * @param clusterId The ID of the cluster the ingester is being removed from.
    */
    function removeIngesterFromCluster(address ingesterAddress, uint256 clusterId) external onlyIngesterProxy {
        uint256 numIngesters = _ingesterClusters[clusterId].ingesterAddresses.length;
        uint256 ingesterIndexToRemove = 0;
        for (uint256 i = 0; i < numIngesters; i++) {
            if (_ingesterClusters[clusterId].ingesterAddresses[i] == ingesterAddress) {
                ingesterIndexToRemove = i;
                //Re-adjust the ingesterAddresses array 
                if (i != numIngesters - 1) {
                    address ingesterAddressToMove = _ingesterClusters[clusterId].ingesterAddresses[numIngesters - 1];
                    _ingesterClusters[clusterId].ingesterAddresses[i] = ingesterAddressToMove;
                }
                _ingesterClusters[clusterId].ingesterAddresses.pop();

                if (_ingesterClusters[clusterId].ingesterAddresses.length == 0) {
                    removeCluster(clusterId);
                    delete _ingesterClusters[clusterId];
                } else {
                    //remove all assignedGroups from ingester within the cluster
                    _ingesterClusters[clusterId].clusterGroupCount -= _ingesterClusters[clusterId].ingesterToAssignedGroups[ingesterAddress].length;
                    _ingesterClusters[clusterId].ingesterToAssignedGroups[ingesterAddress] = new string[](0);

                    //re-calculate cluster remaining capacity
                    _ingesterClusters[clusterId].clusterRemainingCapacity = (_maxGroupsPerIngester * _ingesterClusters[clusterId].ingesterAddresses.length) - _ingesterClusters[clusterId].clusterGroupCount;
                    break;
                }
                
            }
        }
    }

    /**
     * @dev Removes a group from the specified ingester addresses.
     * @param groupUsername The group username to remove.
     * @param ingesterAddresses The array of ingester addresses to remove the group from.
     */
    function removeGroupFromIngesters(string memory groupUsername, address[] memory ingesterAddresses) internal  {
        for (uint256 i = 0; i < ingesterAddresses.length; ++i) {
            address _currentIngesterAddress = ingesterAddresses[i];
            IIngesterRegistration.Ingester memory ingester = ingesterProxy.getIngester(_currentIngesterAddress);
            
            uint256 assignedGroupsIngesterIndex = _groups[groupUsername].ingesterToGroup[_currentIngesterAddress].assignedGroupsIngesterIndex;

            require(assignedGroupsIngesterIndex < ingester.assignedGroups.length, "Index out of bounds");

            string memory groupToMove = ingester.assignedGroups[ingester.assignedGroups.length - 1];

            ingesterProxy.moveIngesterAssignedGroup(_currentIngesterAddress, assignedGroupsIngesterIndex);

            //update move grouped new index to the respective groups storage
            _groups[groupToMove].ingesterToGroup[_currentIngesterAddress].assignedGroupsIngesterIndex = assignedGroupsIngesterIndex;

            emit IIngesterGroupManager.GroupRemovedFromIngester(_currentIngesterAddress, groupUsername);
        }
    }

    /**
    * @notice Removes an ingester from a list of groups.
    * @param groups An array of group usernames the ingester should be removed from.
    * @param ingesterAddress The address of the ingester to be removed.
    */
    function removeIngesterFromGroups(string[] memory groups, address ingesterAddress) external onlyIngesterProxy {
        for (uint256 i = 0; i < groups.length; ++i) {
            // These arrays are capped by the _maxNumberIngesterPerGroup
            uint256 amountOfIngestersPerGroup = _groups[groups[i]].ingesterAddresses.length;
            for (uint256 j = 0; j < amountOfIngestersPerGroup; j++) {
                if(_groups[groups[i]].ingesterAddresses[j] == ingesterAddress ) {
                    //delete ingesterAddress from groups and readjust array length so _maxNumberIngesterPerGroup check remains truthful
                    for (uint256 z = j; z < amountOfIngestersPerGroup - 1; ++z) {
                        _groups[groups[i]].ingesterAddresses[z] = _groups[groups[i]].ingesterAddresses[z+1];
                    }
                    _groups[groups[i]].ingesterAddresses.pop();
                    emit IIngesterGroupManager.IngesterRemovedFromGroup(ingesterAddress, groups[i]);
                    break;
                }
            }
        }
    }

    /**
    * @notice Retrieves the details of a group by its username.
    * @param groupUsername The username of the group to retrieve.
    * @return GroupSlim struct containing the group's details.
    */
    function getGroup(string calldata groupUsername) external view returns (IIngesterGroupManager.GroupSlim memory) {
        IIngesterGroupManager.GroupSlim memory group = IIngesterGroupManager.GroupSlim(
            _groups[groupUsername].isAdded,
            _groups[groupUsername].clusterId,
            _groups[groupUsername].ingesterAddresses, 
            _groups[groupUsername].groupUsernameIndex
        );
        return group;
    }

    /**
    * @notice Retrieves the total number of groups in the system.
    * @return uint256 The total number of groups.
    */
    function getGroupCount() external view returns (uint256) {
        return _groupCount;
    }

    /**
    * @notice Retrieves the group username by its index.
    * @param groupIndex The index of the group in the groups list.
    * @return string The groupUsername of the group corresponding to the provided index.
    */
    function getGroupUsernameByIndex(uint256 groupIndex) external view returns (string memory) {
        return _groupUsernames[groupIndex];
    }

    /**
    * @notice Sets the address of the IngesterProxy contract.
    * @param _ingesterProxyAddress The address of the IngesterProxy contract.
    */
    function setIngesterProxy(address _ingesterProxyAddress) external onlyAdmin {
        ingesterProxyAddress = _ingesterProxyAddress;
        ingesterProxy = IngesterProxy(_ingesterProxyAddress);
    }

    /**
    * @notice Retrieves the list of cluster IDs.
    * @return An array of cluster IDs.
    */
    function getClusters() external view returns (uint256[] memory){
        return _clusterIds;
    }

    /**
    * @notice Retrieves the details of a cluster by its ID.
    * @param clusterId The ID of the cluster to retrieve.
    * @return ClusterSlim struct containing the cluster's details.
    */
    function getCluster(uint256 clusterId) external view returns (IIngesterGroupManager.ClusterSlim memory) {
        IIngesterGroupManager.ClusterSlim memory clusterSlim = IIngesterGroupManager.ClusterSlim(
            _ingesterClusters[clusterId].ingesterAddresses,
            _ingesterClusters[clusterId].clusterGroupCount,
            _ingesterClusters[clusterId].clusterRemainingCapacity
        );
      
        return clusterSlim;
    }

    /**
    * @notice Retrieves the maximum cluster size.
    * @return uint256 The maximum number of ingesters allowed in a cluster.
    */
    function getMaxClusterSize() external view returns (uint256) {
        return _maxClusterSize;
    }

    /**
    * @notice Retrieves the maximum number of groups allowed per ingester.
    * @return uint256 The maximum number of groups per ingester.
    */
    function getMaxGroupsPerIngester() external view returns (uint256) {
        return _maxGroupsPerIngester;
    }

    /**
    * @notice Retrieves the maximum number of ingesters allowed per group.
    * @return uint256 The maximum number of ingesters per group.
    */
    function getMaxNumberIngesterPerGroup() external view returns (uint256) {
        return _maxNumberIngesterPerGroup;
    }

    /**
    * @notice Sets the maximum cluster size.
    * @param maxClusterSize The new maximum number of ingesters allowed in a cluster.
    */
    function setMaxClusterSize(uint256 maxClusterSize) external onlyIngesterProxy {
        _maxClusterSize = maxClusterSize;
    }

    /**
    * @notice Sets the maximum number of groups allowed per ingester.
    * @param maxGroupsPerIngester The new maximum number of groups per ingester.
    */
    function setMaxGroupsPerIngester(uint256 maxGroupsPerIngester) external onlyIngesterProxy {
        _maxGroupsPerIngester = maxGroupsPerIngester;
    }  

    /**
    * @notice Sets the maximum number of ingesters allowed per group.
    * @param maxNumberIngesterPerGroup The new maximum number of ingesters per group.
    */
    function setMaxNumberIngesterPerGroup(uint256 maxNumberIngesterPerGroup) external onlyIngesterProxy {
        require(maxNumberIngesterPerGroup >= 1, "Can only set max ingester per group >= 1");
        _maxNumberIngesterPerGroup = maxNumberIngesterPerGroup;
        emit IIngesterGroupManager.SetNewMaxIngesterPerGroup(maxNumberIngesterPerGroup);
    }

    /**
    * @notice Retrieves the list of unallocated groups.
    * @return An array of unallocated group usernames.
    */
    function getUnallocatedGroups() external view returns(string[] memory) {
        return _unAllocatedGroups;
    }

    /**
    * @notice Updates the address of the IngesterProxy contract.
    * @param newIngesterProxy The address of the new IngesterProxy contract.
    */
    function updateIngesterProxy(address newIngesterProxy) external onlyAdmin {
        ingesterProxyAddress = newIngesterProxy;
    }
}
