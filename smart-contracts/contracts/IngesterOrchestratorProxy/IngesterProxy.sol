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
    IngesterGroupManager private _groupManagerContract;
    IngesterRegistry private _registrationContract;
    IngesterDataGathering public _dataGatheringContract;

    constructor(address _groupManagerContractAddress, address _registrationContractAddress,address _dataGatheringContractAddress) {
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

    function registerIngester(
        address ingesterAddress, 
        string calldata message,
        uint256 nonce,
        bytes calldata sig
    ) external {
        _registrationContract.registerIngester(ingesterAddress, msg.sender, message, nonce, sig);
    }

    function unRegisterIngester(address ingesterAddress) external onlyRegisteredController {
        _registrationContract.unRegisterIngester(ingesterAddress, msg.sender);
    }

    function addIngesterToCluster(address ingesterAddress, address controllerAddress) external onlyRegistrationContract returns (uint256){
        return _groupManagerContract.addIngesterToCluster(ingesterAddress, controllerAddress);
    }

    function removeIngesterFromCluster(address ingesterAddress, uint256 _clusterId) external onlyRegistrationContract {
        _groupManagerContract.removeIngesterFromCluster(ingesterAddress, _clusterId);
    }

    function isRegisteredIngester(address ingesterAddress) public view returns (bool) {
        return _registrationContract.isRegisteredIngester(ingesterAddress);
    }

    function isRegisteredController(address controllerAddress) public view returns (bool) {
        return _registrationContract.isRegisteredController(controllerAddress);
    }

    function getIngester(address ingesterAddress) external view returns (IIngesterRegistration.Ingester memory) {
        return _registrationContract.getIngester(ingesterAddress);
    }

    function getIngesterCount() external view returns (uint256) {
        return _registrationContract.getIngesterCount();
    }

    function getIngesterAddressFromIndex(uint256 index) external view returns(address) {
        return _registrationContract.getIngesterAddressFromIndex(index);
    }

    function getIngesterToController(address ingesterAddress) external view returns(IIngesterRegistration.IngesterToController memory) {
        return _registrationContract.getIngesterToController(ingesterAddress);
    }

    function getControllerIngesters(address controllerAddress) external view returns (IIngesterRegistration.Ingester[] memory) {
        return _registrationContract.getControllerIngesters(controllerAddress);
    }

    function addAssignedGroupToIngester(address ingesterAddress, string memory groupUsername) external onlyGroupManager returns(uint256){
        return _registrationContract.addAssignedGroupToIngester(ingesterAddress, groupUsername);
    }

    function moveIngesterAssignedGroup(address ingesterAddress, uint256 assignedGroupsIngesterIndex) external onlyGroupManager {
        _registrationContract.moveIngesterAssignedGroup(ingesterAddress, assignedGroupsIngesterIndex);
    }

    //Group Manager
    function addGroup(string calldata groupUsername) external onlyAdmin {
        _groupManagerContract.addGroup(groupUsername);
    }

    function removeGroup(string calldata groupUsername) external onlyAdmin {
        _groupManagerContract.removeGroup(groupUsername);
    }

    function getGroup(string calldata group) external view returns (IIngesterGroupManager.GroupSlim memory){
        return _groupManagerContract.getGroup(group);
    }

    function getGroupUsernameByIndex(uint256 groupIndex) external view returns (string memory) {
        return _groupManagerContract.getGroupUsernameByIndex(groupIndex);
    }

    function getGroupCount() external view returns (uint256) {
        return _groupManagerContract.getGroupCount();
    }

    function getClusters() external view returns(uint256[] memory) {
        return _groupManagerContract.getClusters();
    }

    function getCluster(uint256 clusterId) external view returns(IIngesterGroupManager.ClusterSlim memory) {
        return _groupManagerContract.getCluster(clusterId);
    }

    function getMaxClusterSize() external view returns (uint256) {
        return _groupManagerContract.getMaxClusterSize();
    }

    function getMaxGroupsPerIngester() external view returns (uint256) {
        return _groupManagerContract.getMaxGroupsPerIngester();
    }

    function getMaxNumberIngesterPerGroup() external view returns (uint256) {
        return _groupManagerContract.getMaxNumberIngesterPerGroup();
    }

    function setMaxClusterSize(uint256 maxClusterSize) external onlyAdmin {
        _groupManagerContract.setMaxClusterSize(maxClusterSize);
    }

    function setMaxGroupsPerIngester(uint256 maxGroupsPerIngester) external onlyAdmin {
        _groupManagerContract.setMaxGroupsPerIngester(maxGroupsPerIngester);
    }

    function setMaxNumberIngesterPerGroup(uint256 maxNumberIngesterPerGroup) external onlyAdmin {
        _groupManagerContract.setMaxNumberIngesterPerGroup(maxNumberIngesterPerGroup);
    }

    function removeIngesterFromGroups(string[] memory groups, address ingesterAddress) external onlyRegistrationContract {
        _groupManagerContract.removeIngesterFromGroups(groups, ingesterAddress);
    }

    function distributeGroupPostUnregistration(string[] memory groups, uint256 clusterId) external onlyRegistrationContract {
        _groupManagerContract.distributeGroupPostUnregistration(groups, clusterId);
    }

    function distributeGroups(address ingesterAddress) external onlyRegisteredController {
        _groupManagerContract.distributeGroups(ingesterAddress);
    }

    function getUnallocatedGroups() external view returns(string[] memory) {
        return _groupManagerContract.getUnallocatedGroups();
    }

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

    function getIpfsHashes(address ingesterAddress) external view returns(IIngesterDataGatheringProxy.IpfsHash memory ipfsHashes) {
        return _dataGatheringContract.getIpfsHashes(ingesterAddress);
    }
}
