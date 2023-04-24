pragma solidity 0.8.14;


import './IngesterRegistry.sol';
import './IngesterDataGathering.sol';
import './IngesterGroupManager.sol';
import '../interfaces/IngesterOrchestratorProxy/IIngesterDataGathering.sol';
import '../interfaces/IngesterOrchestratorProxy/IIngesterGroupManager.sol';
import '../interfaces/IngesterOrchestratorProxy/IIngesterProxy.sol';
import "@openzeppelin/contracts/access/AccessControlEnumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract IngesterProxy is AccessControlEnumerable, Ownable, IIngesterProxy {
    address public groupManagerContractAddress;
    address public registrationContractAddress;
    address public dataGatheringContractAddress;
    IngesterGroupManager private _groupManagerContract;
    IngesterRegistry private _registrationContract;
    IngesterDataGathering public _dataGatheringContract;

    constructor(address _groupManagerContractAddress, address _registrationContractAddress,address _dataGatheringContractAddress) {
        require(_groupManagerContractAddress != address(0), "GroupManagerContractAddress: Proxy address should not be zero");
        require(_registrationContractAddress != address(0), "RegistrationContractAddress: Proxy address should not be zero");
        require(_dataGatheringContractAddress != address(0), "DataGatheringContractAddress: Proxy address should not be zero");

        groupManagerContractAddress = _groupManagerContractAddress;
        registrationContractAddress = _registrationContractAddress;
        dataGatheringContractAddress = _dataGatheringContractAddress;
        _groupManagerContract = IngesterGroupManager(_groupManagerContractAddress);
        _registrationContract = IngesterRegistry(_registrationContractAddress);
        _dataGatheringContract = IngesterDataGathering(_dataGatheringContractAddress); 
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    modifier onlyRegisteredController() {
        require(isRegisteredController(msg.sender), "Caller is not a registered controller");
        _;
    }

    modifier onlyRegisteredIngester() {
        require(isRegisteredIngester(msg.sender), "Caller is not a registered ingester");
        _;
    }

    modifier onlyGroupManager() {
        require(msg.sender == groupManagerContractAddress, "Caller is not group manager contract");
        _;
    }

    modifier onlyRegistrationContract() {
        require(msg.sender == registrationContractAddress, "Caller is not registration contract");
        _;
    }

    modifier onlyAdmin() {
        require(hasRole(DEFAULT_ADMIN_ROLE, msg.sender), "Only admin can perform this action.");
        _;
    }

    function transferOwnership(address newOwner) public onlyAdmin override {
        super.transferOwnership(newOwner);
    }

    /**
    * @notice Updates the address of the GroupManager contract and sets a new instance.
    * @dev Can only be called by an admin.
    * @param newGroupManagerContractAddress The address of the new GroupManager contract.
    */
    function updateGroupManagerContract(address newGroupManagerContractAddress) external onlyAdmin {
        require(newGroupManagerContractAddress != address(0), "New group manager contract address cannot be a zero address.");
        groupManagerContractAddress = newGroupManagerContractAddress;
        _groupManagerContract = IngesterGroupManager(newGroupManagerContractAddress);
        emit GroupManagerContractAddressUpdated(newGroupManagerContractAddress);
    }

    /**
    * @notice Updates the address of the Registration contract and sets a new instance.
    * @dev Can only be called by an admin.
    * @param newRegistrationContractAddress The address of the new Registration contract.
    */
    function updateRegistrationContract(address newRegistrationContractAddress) external onlyAdmin {
        require(newRegistrationContractAddress != address(0), "New registration contract address cannot be a zero address.");
        registrationContractAddress = newRegistrationContractAddress;
        _registrationContract = IngesterRegistry(newRegistrationContractAddress);
        emit RegistrationContractAddressUpdated(newRegistrationContractAddress);
    }

    /**
    * @notice Updates the address of the DataGathering contract and sets a new instance.
    * @dev Can only be called by an admin.
    * @param newDataGatheringContractAddress The address of the new DataGathering contract.
    */
    function updateDataGatheringContract(address newDataGatheringContractAddress) external onlyAdmin {
        require(newDataGatheringContractAddress != address(0), "New data gathering contract address cannot be a zero address.");
        dataGatheringContractAddress = newDataGatheringContractAddress;
        _dataGatheringContract = IngesterDataGathering(newDataGatheringContractAddress);
        emit DataGatheringContractAddressUpdated(newDataGatheringContractAddress);
    }

    /**
    * @notice Registers an ingester with the provided message, nonce, and signature.
    * @param ingesterAddress The address of the ingester to be registered.
    * @param message The message to be registered with the ingester.
    * @param nonce The nonce used for the registration.
    * @param sig The signature of the registration.
    */
    function registerIngester(
        address ingesterAddress, 
        string calldata message,
        uint256 nonce,
        bytes calldata sig
    ) external {
        _registrationContract.registerIngester(ingesterAddress, msg.sender, message, nonce, sig);
    }

    /**
    * @notice Calculates the keccak256 hash of the given input parameters.
    * @dev This function is used for generating the message hash for signature verification.
    * @param _address The address used for hashing.
    * @param _value The string value used for hashing.
    * @param _nonce The nonce used for hashing.
    * @return hash The keccak256 hash of the input parameters.
    */
    function hash(address _address, string calldata _value, uint256 _nonce) external view returns (bytes32) {
        return _registrationContract.hash(_address, _value, _nonce);
    }

    /**
    * @notice Unregisters an ingester and removes its association with the controller.
    * @dev Can only be called by a registered controller.
    * @param ingesterAddress The address of the ingester to be unregistered.
    */
    function unRegisterIngester(address ingesterAddress) external onlyRegisteredController {
        _registrationContract.unRegisterIngester(ingesterAddress, msg.sender);
    }

    /**
    * @notice Adds an ingester to a cluster.
    * @param ingesterAddress The address of the ingester to be added to the cluster.
    * @param controllerAddress The address of the controller adding the ingester to the cluster.
    * @return The cluster ID where the ingester was added.
    */
    function addIngesterToCluster(address ingesterAddress, address controllerAddress) external onlyRegistrationContract returns (uint256){
        return _groupManagerContract.addIngesterToCluster(ingesterAddress, controllerAddress);
    }

    /**
    * @notice Retrieves the assigned groups for a given ingester address and cluster ID by calling the Group Manager contract.
    * @param ingesterAddress The address of the ingester.
    * @param clusterId The ID of the cluster the ingester belongs to.
    * @return An array of group usernames assigned to the ingester.
    */
    function getIngesterAssignedGroups(address ingesterAddress, uint256 clusterId) external view returns (string[] memory) {
        return _groupManagerContract.getIngesterAssignedGroups(ingesterAddress, clusterId);
    }

    /**
    * @notice Adds an ingester to a cluster.
    * @param ingesterAddress The address of the ingester to be added to the cluster.
    * @param clusterId The cluster ID where the ingester was added.
    */
    function removeIngesterFromCluster(address ingesterAddress, uint256 clusterId) external onlyRegistrationContract {
        _groupManagerContract.removeIngesterFromCluster(ingesterAddress, clusterId);
    }

    /**
    * @notice Checks if the given address is a registered ingester.
    * @param ingesterAddress The address to check for ingester registration.
    * @return True if the address is a registered ingester, false otherwise.
    */
    function isRegisteredIngester(address ingesterAddress) public view returns (bool) {
        return _registrationContract.isRegisteredIngester(ingesterAddress);
    }

    /**
    * @notice Checks if the given address is a registered controller.
    * @param controllerAddress The address to check for controller registration.
    * @return True if the address is a registered controller, false otherwise.
    */
    function isRegisteredController(address controllerAddress) public view returns (bool) {
        return _registrationContract.isRegisteredController(controllerAddress);
    }
    
    /**
    * @notice Retrieves ingester details for a given ingester address.
    * @param ingesterAddress The address of the ingester.
    * @return Ingester struct containing ingester details.
    */
    function getIngester(address ingesterAddress) external view returns (IIngesterRegistration.Ingester memory) {
        return _registrationContract.getIngester(ingesterAddress);
    }

    /**
    * @notice Retrieves ingester details for a given ingester address.
    * @param ingesterAddress The address of the ingester.
    * @return Ingester struct containing ingester details.
    */
    function getIngesterWithGroups(address ingesterAddress) external view returns (IIngesterRegistration.IngesterWithGroups memory) {
        return _registrationContract.getIngesterWithGroups(ingesterAddress);
    }
    
    /**
    * @notice Retrieves the total count of registered ingesters.
    * @return The total count of registered ingesters.
    */
    function getIngesterCount() external view returns (uint256) {
        return _registrationContract.getIngesterCount();
    }

    /**
    * @notice Retrieves the ingester address at a given index in the registry.
    * @param index The index of the ingester in the registry.
    * @return The address of the ingester at the given index.
    */
    function getIngesterAddressFromIndex(uint256 index) external view returns(address) {
        return _registrationContract.getIngesterAddressFromIndex(index);
    }

    /**
    * @notice Retrieves the IngesterToController struct for a given ingester address.
    * @param ingesterAddress The address of the ingester.
    * @return IngesterToController struct containing controller details.
    */
    function getIngesterToController(address ingesterAddress) external view returns(IIngesterRegistration.IngesterToController memory) {
        return _registrationContract.getIngesterToController(ingesterAddress);
    }

    /**
    * @notice Retrieves the list of ingesters for a given controller address.
    * @param controllerAddress The address of the controller.
    * @return An array of Ingester structs containing ingester details.
    */
    function getControllerIngesters(address controllerAddress) external view returns (IIngesterRegistration.Ingester[] memory) {
        return _registrationContract.getControllerIngesters(controllerAddress);
    }

    /**
    * @notice Adds a new group to the group manager.
    * @param groupUsername The username of the group to be added.
    */
    function addGroup(string calldata groupUsername) external onlyAdmin {
        _groupManagerContract.addGroup(groupUsername);
    }

    /**
    * @notice Removes a group from the group manager.
    * @param groupUsername The username of the group to be removed.
    */
    function removeGroup(string calldata groupUsername) external onlyAdmin {
        _groupManagerContract.removeGroup(groupUsername);
    }

    /**
    * @notice Retrieves the group details for a given group username.
    * @param group The username of the group.
    * @return GroupSlim struct containing group details.
    */
    function getGroup(string calldata group) external view returns (IIngesterGroupManager.GroupSlim memory){
        return _groupManagerContract.getGroup(group);
    }

    /**
    * @notice Retrieves the group username at a given index in the group manager.
    * @param groupIndex The index of the group in the group manager.
    * @return The username of the group at the given index.
    */
    function getGroupUsernameByIndex(uint256 groupIndex) external view returns (string memory) {
        return _groupManagerContract.getGroupUsernameByIndex(groupIndex);
    }

    /**
    * @notice Retrieves the total count of groups in the group manager.
    * @return The total count of groups in the group manager.
    */
    function getGroupCount() external view returns (uint256) {
        return _groupManagerContract.getGroupCount();
    }

    /**
    * @notice Retrieves the list of cluster IDs.
    * @return An array of cluster IDs.
    */
    function getClusters() external view returns(uint256[] memory) {
        return _groupManagerContract.getClusters();
    }

    /**
    * @notice Retrieves the cluster details for a given cluster ID.
    * @param clusterId The ID of the cluster.
    * @return ClusterSlim struct containing cluster details.
    */
    function getCluster(uint256 clusterId) external view returns(IIngesterGroupManager.ClusterSlim memory) {
        return _groupManagerContract.getCluster(clusterId);
    }

    /**
    * @notice Retrieves the maximum size of a cluster.
    * @return The maximum size of a cluster.
    */
    function getMaxClusterSize() external view returns (uint256) {
        return _groupManagerContract.getMaxClusterSize();
    }

    /**
    * @notice Retrieves the maximum number of groups that an ingester can be assigned.
    * @return The maximum number of groups per ingester.
    */
    function getMaxGroupsPerIngester() external view returns (uint256) {
        return _groupManagerContract.getMaxGroupsPerIngester();
    }

    /**
    * @notice Retrieves the maximum number of ingesters that can be assigned to a group.
    * @return The maximum number of ingesters per group.
    */
    function getMaxNumberIngesterPerGroup() external view returns (uint256) {
        return _groupManagerContract.getMaxNumberIngesterPerGroup();
    }

    /**
    * @notice Sets the maximum size of a cluster.
    * @param maxClusterSize The new maximum size of a cluster.
    */
    function setMaxClusterSize(uint256 maxClusterSize) external onlyAdmin {
        _groupManagerContract.setMaxClusterSize(maxClusterSize);
    }

    /**
    * @notice Sets the maximum number of groups that an ingester can be assigned.
    * @param maxGroupsPerIngester The new maximum number of groups per ingester.
    */
    function setMaxGroupsPerIngester(uint256 maxGroupsPerIngester) external onlyAdmin {
        _groupManagerContract.setMaxGroupsPerIngester(maxGroupsPerIngester);
    }

    /**
    * @notice Sets the maximum number of ingesters that can be assigned to a group.
    * @param maxNumberIngesterPerGroup The new maximum number of ingesters per group.
    */
    function setMaxNumberIngesterPerGroup(uint256 maxNumberIngesterPerGroup) external onlyAdmin {
        _groupManagerContract.setMaxNumberIngesterPerGroup(maxNumberIngesterPerGroup);
    }

    /**
    * @notice Removes an ingester from the specified groups.
    * @param clusterId The Id of the cluster that the ingester is part of.
    * @param ingesterAddress The address of the ingester to be removed from the groups.
    */
    function removeIngesterFromGroups(uint256 clusterId, address ingesterAddress) external onlyRegistrationContract {
        _groupManagerContract.removeIngesterFromGroups(clusterId, ingesterAddress);
    }

    /**
    * @notice Redistributes groups among clusters after an ingester is unregistered.
    * @param groups An array of group usernames.
    * @param clusterId The ID of the cluster that the ingester was part of.
    */
    function distributeGroupPostUnregistration(string[] memory groups, uint256 clusterId) external onlyRegistrationContract {
        _groupManagerContract.distributeGroupPostUnregistration(groups, clusterId);
    }

    /**
    * @notice Assigns groups to an ingester.
    * @param ingesterAddress The address of the ingester to be assigned groups.
    */
    function distributeGroups(address ingesterAddress) external onlyRegisteredController {
        _groupManagerContract.distributeGroups(ingesterAddress);
    }

    /**
    * @notice Retrieves the list of unallocated groups.
    * @return An array of unallocated group usernames.
    */
    function getUnallocatedGroups() external view returns(string[] memory) {
        return _groupManagerContract.getUnallocatedGroups();
    }

    /**
    * @notice Adds IPFS hashes for ingester data to the data gathering contract.
    * @param usersHash The IPFS hash for user data.
    * @param chatsHash The IPFS hash for chat data.
    * @param messagesHash The IPFS hash for message data.
    */
    function addIpfsHash(
        string calldata usersHash,
        string calldata chatsHash,
        string calldata messagesHash
    ) external onlyRegisteredIngester {
        _dataGatheringContract.addIpfsHash(
            msg.sender,
            usersHash,
            chatsHash,
            messagesHash);
    }

    /**
    * @notice Retrieves the IPFS hashes for a given ingester address.
    * @param ingesterAddress The address of the ingester.
    * @return IpfsHash struct containing ingester IPFS hashes.
    */
    function getIpfsHashes(address ingesterAddress) external view returns(IIngesterDataGathering.IpfsHash memory) {
        return _dataGatheringContract.getIpfsHashes(ingesterAddress);
    }
}
