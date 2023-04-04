// SPDX-License-Identifier: MIT
pragma solidity 0.8.14;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "../interfaces/IngesterOrchestratorProxy/IIngesterGroupManager.sol";
import "../interfaces/IngesterOrchestratorProxy/IIngesterRegistration.sol";

import "./IngesterProxy.sol";

contract IngesterGroupManager is AccessControl, IIngesterGroupManager {

    address public ingesterProxyAddress;
    IngesterProxy public ingesterProxy;
    uint256 maxClusterSize; // 5
    uint256 maxGroupsPerIngester; // 300

    mapping(uint => Cluster) private ingesterClusters;
    uint256[] private clusterIds;
    mapping(string => Group) private groups;
    string[] public groupUsernames;
    uint256 public maxNumberIngesterPerGroup;
    uint256 public groupCount;

    //TODO: maxNumberIngesterPerGroup for customization of group replication across ingesters
    constructor(address _ingesterProxyAddress, uint256 _maxClusterSize, uint256 _maxGroupsPerIngester, uint256 _maxNumberIngesterPerGroup) {
        ingesterProxyAddress = _ingesterProxyAddress;
        ingesterProxy = IngesterProxy(_ingesterProxyAddress);
        maxClusterSize = _maxClusterSize;
        maxGroupsPerIngester = _maxGroupsPerIngester;
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

    function getClusters() external returns (uint256[] memory){
        return clusterIds;
    }

    function getCluster(uint256 _id) external returns (uint256) {
        for (uint256 i = 0; i < clusterIds.length; i++) {
            if (clusterIds[i] == _id) {
                return clusterIds[i];
            }
        }
    }

    function distributeGroup(string memory _groupUsername) internal {
        uint clusterId = getLowestSaturatedCluster();

        //make sure it rounds up in this operation to allow for adding new groups when remainder > 0
        uint256 numIngesters = ingesterClusters[clusterId].ingesterAddresses.length;
        uint256 _maxGroupsPerIngester = (ingesterClusters[clusterId].clusterGroups.length + numIngesters - 1) / numIngesters;
        for (uint256 i = 0; i < numIngesters; ++i) {
            address currentIngesterAddress = ingesterClusters[clusterId].ingesterAddresses[i];
            IIngesterRegistration.Ingester memory ingester = ingesterProxy.getIngesterDetails(currentIngesterAddress);

            uint256 numOfAssignedGroups = ingester.assignedGroups.length;
            uint256 numIngestersPerGroup = groups[_groupUsername].ingesterAddresses.length;

            if (numOfAssignedGroups < _maxGroupsPerIngester && numIngestersPerGroup < maxNumberIngesterPerGroup) {
                //assign group to ingester
                ingesterProxy.addAssignedGroupToIngester(currentIngesterAddress, _groupUsername);
                //update _groups storage to include the new ingester and the respective group index in the ingesters storage
                groups[_groupUsername].ingesterAddresses.push(currentIngesterAddress);
                groups[_groupUsername].assignedGroupsIngesterIndex[currentIngesterAddress] = ingester.assignedGroups.length - 1;

                ingesterClusters[clusterId].clusterGroups.push(_groupUsername);
                //adjust saturation ratio 
                ingesterClusters[clusterId].saturationRatio = ingesterClusters[clusterId].clusterGroups.length / (ingesterClusters[clusterId].ingesterAddresses.length * maxGroupsPerIngester);

                break;
            }
        }
    }

   

    // Cluster 1
    // - 5 Ingesters
    // - 300 groups
    // Saturation , 0-1
    // Cluster 2
    //TODO: Explore doing a bubble sort to keep array from lowest saturation to highest, would avoid iterating throught the whole thing everytime
    // 
    // currentLowestSaturationClusterIndex
    // keep index of last cluster
    // keep index of last ingester within cluster to know what was the last distribution
    // Can you do this when you remove ingesters and groups? do these indexes help?

    function getLowestSaturatedCluster() internal returns(uint256) {
        uint256 lowestSaturatedCluster = 1;
        for (uint256 i = 0; i < clusterIds.length; i++) {
            if (ingesterClusters[clusterIds[i]].saturationRatio < lowestSaturatedCluster) {
                lowestSaturatedCluster = ingesterClusters[clusterIds[i]].saturationRatio;
            }
        }
        return lowestSaturatedCluster;
    }

    function distributeGroupPostUnregistration(string[] memory _groups) external onlyIngesterProxy {
        distributeGroup(_groups);
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
            ingesterClusters[clusterId].ingesterAddresses.push(_ingesterAddress);
            return clusterId;
        } else {
            clusterId = getAvailableCluster();
            ingesterClusters[clusterId].ingesterAddresses.push(_ingesterAddress);
            return clusterId;
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
            availableCluster = clusterIds.length;
            clusterIds.push(availableCluster);
            return availableCluster;
        } else {
            return availableCluster;
        }
    }

    function removingGroupFromIngesters(string memory _groupUsername, address[] memory _ingesterAddresses) internal  {
        for (uint256 i = 0; i < _ingesterAddresses.length; ++i) {
            address _currentIngester = _ingesterAddresses[i];
            IIngesterRegistration.Ingester memory ingester = ingesterProxy.getIngesterDetails(_currentIngester);
            
            uint256 assignedGroupsIngesterIndex = groups[_groupUsername].assignedGroupsIngesterIndex[_currentIngester];

            require(assignedGroupsIngesterIndex < ingester.assignedGroups.length, "Index out of bounds");

            string memory groupToMove = ingester.assignedGroups[ingester.assignedGroups.length - 1];

            ingesterProxy.moveIngesterAssignedGroup(_currentIngester, assignedGroupsIngesterIndex);

            //update move grouped new index to the respective groups storage
            groups[groupToMove].assignedGroupsIngesterIndex[_currentIngester] = assignedGroupsIngesterIndex;

            emit IIngesterGroupManager.GroupRemovedFromIngester(_currentIngester, _groupUsername);
        }
    }

    function removeIngesterFromGroups(string[] memory _groups, address _ingesterAddress) internal {
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

    function getGroup(string calldata groupUsername) public view returns (IIngesterGroupManager.GroupToIngester memory) {
        IIngesterGroupManager.GroupToIngester memory group = IIngesterGroupManager.GroupToIngester(
            groups[groupUsername].isAdded,
            groups[groupUsername].clusterId,
            groups[groupUsername].ingesterAddresses, 
            groups[groupUsername].groupUsernameIndex
        );
        return group;
    }

    function setMaxNumberIngesterPerGroup(uint256 maxNumberIngesterPerGroup) external onlyAdmin {
        maxNumberIngesterPerGroup = maxNumberIngesterPerGroup;
        emit IIngesterGroupManager.SetNewMaxIngesterPerGroup(maxNumberIngesterPerGroup);
    }

    function updateIngesterProxy(address newIngesterProxy) external onlyAdmin {
        ingesterProxyAddress = newIngesterProxy;
    }
}
