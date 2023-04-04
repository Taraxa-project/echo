pragma solidity 0.8.14;


import './IngesterRegistry.sol';
import './IngesterDataGathering.sol';
import './IngesterGroupManager.sol';
import '../interfaces/IngesterOrchestratorProxy/IIngesterDataGatheringProxy.sol';
import "@openzeppelin/contracts/access/AccessControl.sol";

// add ingesterDataGathering Interface
contract IngesterProxy is AccessControl {
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

    function getIngesterDetails(address _ingesterAddress) external view returns (IngesterRegistry.Ingester memory) {
        return registrationContract.getIngesterDetails(_ingesterAddress);
    }

    function addAssignedGroupToIngester(address _ingesterAddress, string memory _groupUsername) external onlyGroupManager {
        registrationContract.addAssignedGroupToIngester(_ingesterAddress, _groupUsername);
    }

    function moveIngesterAssignedGroup(address _ingesterAddress, uint256 _assignedGroupsIngesterIndex) external onlyGroupManager {
        registrationContract.moveIngesterAssignedGroup(_ingesterAddress, _assignedGroupsIngesterIndex);
    }

    function setMaxNumberIngesterPerGroup(uint256 _maxNumberIngesterPerGroup) external onlyAdmin {
        groupManagerContract.setMaxNumberIngesterPerGroup(_maxNumberIngesterPerGroup);
    }

    function addGroup(string calldata _groupUsername) external onlyAdmin {
        groupManagerContract.addGroup(_groupUsername);
    }

    function removeGroup(string calldata _groupUsername) external onlyAdmin {
        groupManagerContract.removeGroup(_groupUsername);
    }

    function removeIngesterFromGroups(string[] memory _groups, address _ingesterAddress) external onlyRegistrationContract {
        groupManagerContract.removeIngesterFromGroups(_groups, _ingesterAddress);
    }

    function distributeGroupPostUnregistration(string[] memory _groups) external onlyRegistrationContract {
        ingesterProxy.distributeGroupPostUnregistration(ingesterAssignedGroups[i]);
    }

    function addIpfsHash(
        address _ingesterAddress,
        string calldata _usersHash,
        string calldata _chatsHash,
        string calldata _messagesHash
    ) external onlyRegisteredController {
        require(isRegisteredIngester(_ingesterAddress), "Ingester is not registered");

        dataGatheringContract.addIpfsHash(
            _ingesterAddress,
            _usersHash,
            _chatsHash,
            _messagesHash);
    }

    function getIpfsHashes(address _ingesterAddress) external view returns(IIngesterDataGatheringProxy.IpfsHash memory ipfsHashes) {
        return dataGatheringContract.getIpfsHashes(_ingesterAddress);
    }
}
