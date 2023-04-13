pragma solidity 0.8.14;


import './IngesterRegistry.sol';
import './IngesterDataGathering.sol';
import './IngesterGroupManager.sol';
import '../interfaces/IngesterOrchestratorProxy/IIngesterDataGatheringProxy.sol';
import '../interfaces/IngesterOrchestratorProxy/IIngesterGroupManager.sol';
import "@openzeppelin/contracts/access/AccessControlEnumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// add ingesterDataGathering Interface
contract IngesterProxy is AccessControlEnumerable, Ownable {
    address public groupManagerContractAddress;
    address public registrationContractAddress;
    address public dataGatheringContractAddress;
    IngesterGroupManager private groupManagerContract;
    IngesterRegistry private registrationContract;
    IngesterDataGathering public dataGatheringContract;

    constructor(address _groupManagerContractAddress, address _registrationContractAddress,address _dataGatheringContractAddress) {
        groupManagerContractAddress = _groupManagerContractAddress;
        registrationContractAddress = _registrationContractAddress;
        dataGatheringContractAddress = _dataGatheringContractAddress;
        groupManagerContract = IngesterGroupManager(_groupManagerContractAddress);
        dataGatheringContract = IngesterDataGathering(_dataGatheringContractAddress);
        registrationContract = IngesterRegistry(_registrationContractAddress);
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

    function registerIngester(
        address _ingesterAddress, 
        string calldata message,
        uint256 nonce,
        bytes calldata sig
    ) external {
        registrationContract.registerIngester(_ingesterAddress, msg.sender, message, nonce, sig);
    }

    function unRegisterIngester(address _ingesterAddress) external onlyRegisteredController {
        registrationContract.unRegisterIngester(_ingesterAddress, msg.sender);
    }

    function addIngesterToCluster(address _ingesterAddress) external onlyRegistrationContract returns (uint256){
        return groupManagerContract.addIngesterToCluster(_ingesterAddress);
    }

    function removeIngesterFromCluster(address _ingesterAddress, uint256 _clusterId) external onlyRegistrationContract returns (uint256) {
        groupManagerContract.removeIngesterFromCluster(_ingesterAddress, _clusterId);
    }

    function isRegisteredIngester(address _ingesterAddress) public view returns (bool) {
        return registrationContract.isRegisteredIngester(_ingesterAddress);
    }

    function isRegisteredController(address _controllerAddress) public view returns (bool) {
        return registrationContract.isRegisteredController(_controllerAddress);
    }

    function getIngester(address _ingesterAddress) external view returns (IngesterRegistry.Ingester memory) {
        return registrationContract.getIngester(_ingesterAddress);
    }

    function getIngesterCount() external view returns (uint256) {
        return registrationContract.getIngesterCount();
    }

    function getIngesterAddressFromIndex(uint256 _index) external view returns(address) {
        return registrationContract.getIngesterAddressFromIndex(_index);
    }

    function addAssignedGroupToIngester(address _ingesterAddress, string memory _groupUsername) external onlyGroupManager returns(uint256){
        return registrationContract.addAssignedGroupToIngester(_ingesterAddress, _groupUsername);
    }

    function moveIngesterAssignedGroup(address _ingesterAddress, uint256 _assignedGroupsIngesterIndex) external onlyGroupManager {
        registrationContract.moveIngesterAssignedGroup(_ingesterAddress, _assignedGroupsIngesterIndex);
    }

    //Group Manager
    function addGroup(string calldata _groupUsername) external onlyAdmin {
        groupManagerContract.addGroup(_groupUsername);
    }

    function removeGroup(string calldata _groupUsername) external onlyAdmin {
        groupManagerContract.removeGroup(_groupUsername);
    }

    function getGroup(string calldata _group) external view returns (IIngesterGroupManager.GroupToIngester memory){
        return groupManagerContract.getGroup(_group);
    }

    function getGroupUsernameByIndex(uint256 groupIndex) external view returns (string memory) {
        return groupManagerContract.getGroupUsernameByIndex(groupIndex);
    }

    function getGroupCount() external view returns (uint256) {
        return groupManagerContract.getGroupCount();
    }

    function getClusters() external view returns(uint256[] memory) {
        return groupManagerContract.getClusters();
    }

    function getCluster(uint256 clusterId) external view returns(IIngesterGroupManager.ClusterSlim memory) {
        return groupManagerContract.getCluster(clusterId);
    }

    function getMaxClusterSize() external view returns (uint256) {
        return groupManagerContract.getMaxClusterSize();
    }

    function getMaxGroupsPerIngester() external view returns (uint256) {
        return groupManagerContract.getMaxGroupsPerIngester();
    }

    function getMaxNumberIngesterPerGroup() external view returns (uint256) {
        return groupManagerContract.getMaxNumberIngesterPerGroup();
    }

    function setMaxClusterSize(uint256 _maxClusterSize) external onlyAdmin {
        groupManagerContract.setMaxClusterSize(_maxClusterSize);
    }

    function setMaxGroupsPerIngester(uint256 _maxGroupsPerIngester) external onlyAdmin {
        groupManagerContract.setMaxGroupsPerIngester(_maxGroupsPerIngester);
    }

    function setMaxNumberIngesterPerGroup(uint256 _maxNumberIngesterPerGroup) external onlyAdmin {
        groupManagerContract.setMaxNumberIngesterPerGroup(_maxNumberIngesterPerGroup);
    }

    function removeIngesterFromGroups(string[] memory _groups, address _ingesterAddress) external onlyRegistrationContract {
        groupManagerContract.removeIngesterFromGroups(_groups, _ingesterAddress);
    }

    function distributeGroupPostUnregistration(string[] memory _groups) external onlyRegistrationContract {
        groupManagerContract.distributeGroupPostUnregistration(_groups);
    }

    function distributeGroupsPostRegistration() external onlyRegistrationContract {
        groupManagerContract.distributeGroupsPostRegistration();
    }

    function getUnallocatedGroups() external view returns(string[] memory) {
        return groupManagerContract.getUnallocatedGroups();
    }


    function addIpfsHash(
        string calldata _usersHash,
        string calldata _chatsHash,
        string calldata _messagesHash
    ) external onlyRegisteredIngester {
        dataGatheringContract.addIpfsHash(
            msg.sender,
            _usersHash,
            _chatsHash,
            _messagesHash);
    }

    function getIpfsHashes(address _ingesterAddress) external view returns(IIngesterDataGatheringProxy.IpfsHash memory ipfsHashes) {
        return dataGatheringContract.getIpfsHashes(_ingesterAddress);
    }
}
