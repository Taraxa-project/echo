pragma solidity ^0.8.0;

import './IIngesterGroupManager.sol';
import './IIngesterDataGathering.sol';
import './IIngesterRegistration.sol';

interface IIngesterProxy {
    // Events
    event AdminChanged(address indexed previousAdmin, address indexed newAdmin);
    event GroupManagerContractAddressUpdated(address newGroupManagerContractAddress);
    event RegistrationContractAddressUpdated(address newGroupManagerContractAddress);
    event DataGatheringContractAddressUpdated(address newGroupManagerContractAddress);

    // Structs
    struct IngesterToController {
        address controller;
        bool isRegistered;
    }

    // Functions
    function registerIngester(address ingesterAddress, string calldata message, uint256 nonce, bytes calldata sig) external;

    function unRegisterIngester(address ingesterAddress) external;

    function getIngesterCount() external view returns (uint256);

    function getIngesterAddressFromIndex(uint256 index) external view returns(address);

    function getIngesterToController(address ingesterAddress) external view returns(IIngesterRegistration.IngesterToController memory);

    function getControllerIngesters(address controllerAddress) external view returns (IIngesterRegistration.Ingester[] memory);

    function addGroup(string calldata groupUsername) external;

    function removeGroup(string calldata groupUsername) external;

    function getGroup(string calldata group) external view returns (IIngesterGroupManager.GroupSlim memory);

    function getGroupUsernameByIndex(uint256 groupIndex) external view returns (string memory);

    function getGroupCount() external view returns (uint256);

    function getClusters() external view returns(uint256[] memory);

    function getCluster(uint256 clusterId) external view returns(IIngesterGroupManager.ClusterSlim memory);

    function getMaxClusterSize() external view returns (uint256);

    function getMaxGroupsPerIngester() external view returns (uint256);

    function getMaxNumberIngesterPerGroup() external view returns (uint256);

    function setMaxClusterSize(uint256 maxClusterSize) external;

    function setMaxGroupsPerIngester(uint256 maxGroupsPerIngester) external;

    function setMaxNumberIngesterPerGroup(uint256 maxNumberIngesterPerGroup) external;

    function removeIngesterFromGroups(uint256 clusterId, address ingesterAddress) external;

    function distributeGroupPostUnregistration(string[] memory groups, uint256 clusterId) external;

    function distributeGroups(address ingesterAddress) external;

    function getUnallocatedGroups() external view returns(string[] memory);

    function addIpfsHash(string calldata usersHash, string calldata chatsHash, string calldata messagesHash) external;

    function getIpfsHashes(address ingesterAddress) external view returns(IIngesterDataGathering.IpfsHash memory);
}
