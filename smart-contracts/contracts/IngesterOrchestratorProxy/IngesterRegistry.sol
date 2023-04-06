// SPDX-License-Identifier: MIT
pragma solidity 0.8.14;

import "@openzeppelin/contracts/access/AccessControlEnumerable.sol";
import "../interfaces/IngesterOrchestratorProxy/IIngesterGroupManager.sol";
import "../interfaces/IngesterOrchestratorProxy/IIngesterRegistration.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import './IngesterProxy.sol';
import "hardhat/console.sol";


contract IngesterRegistry is AccessControlEnumerable, IIngesterRegistration {
    bytes32 public constant INGESTER_ROLE = keccak256("INGESTER_ROLE");
    bytes32 public constant CONTROLLER_ROLE = keccak256("CONTROLLER_ROLE");

    address public ingesterProxyAddress;
    IngesterProxy public ingesterProxy;

    mapping(address => Ingester[]) private controllerToIngesters;
    mapping(address => IngesterToController) private ingesterToController;
    address[] private ingesterAddresses;
    uint private ingesterCount;


    constructor() {
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    modifier onlyIngesterProxy() {
        require(msg.sender == ingesterProxyAddress, "Caller is not the IngesterProxy");
        _;
    }

    modifier onlyAdmin() {
        require(hasRole(DEFAULT_ADMIN_ROLE, msg.sender), "Caller is not admin");
        _;
    }

    function setIngesterProxy(address _ingesterProxyAddress) external onlyAdmin{
        ingesterProxyAddress = _ingesterProxyAddress;
        ingesterProxy = IngesterProxy(_ingesterProxyAddress);
        _setupRole(DEFAULT_ADMIN_ROLE, _ingesterProxyAddress);
    }

    function registerIngester(
        address _ingesterAddress, 
        address _controllerAddress,
        string calldata message,
        uint256 nonce,
        bytes calldata sig
        ) external onlyIngesterProxy {
        require(ingesterToController[_ingesterAddress].controllerAddress != _controllerAddress, "Ingester already exists");
       
        bytes32 messageHash = _hash(_ingesterAddress, message, nonce);

        bytes32 ethSignedMessageHash = getEthSignedMessageHash(messageHash);

        require(ECDSA.recover(ethSignedMessageHash, sig) == _ingesterAddress, "Invalid signature.");
        
        //add the ingester to an available cluster
        //return the cluster it was added and add that to ingester structure
        uint256 clusterId = ingesterProxy.addIngesterToCluster(_ingesterAddress);

        Ingester memory ingester = IIngesterRegistration.Ingester(_ingesterAddress, true, clusterId, new string[](0));

        controllerToIngesters[_controllerAddress].push(ingester);

        ingesterAddresses.push(_ingesterAddress);
        ingesterToController[_ingesterAddress] = IIngesterRegistration.IngesterToController(_controllerAddress, controllerToIngesters[_controllerAddress].length - 1, ingesterAddresses.length - 1);
        ++ingesterCount;


        _grantRole(INGESTER_ROLE, _ingesterAddress);
        _grantRole(CONTROLLER_ROLE, _controllerAddress);

        emit IIngesterRegistration.IngesterRegistered(_controllerAddress, _ingesterAddress);
    }

    function unRegisterIngester(address _ingesterAddress, address _controllerAddress) external onlyIngesterProxy {
        require(ingesterToController[_ingesterAddress].controllerAddress == _controllerAddress, "Ingester does not exist");
        console.log('ingesterAddress', _ingesterAddress);
        address controller = ingesterToController[_ingesterAddress].controllerAddress;
        uint256 ingesterIndexToRemove = ingesterToController[_ingesterAddress].ingesterIndex;
        string[] memory ingesterAssignedGroups = controllerToIngesters[_controllerAddress][ingesterIndexToRemove].assignedGroups;
        console.log('am I getting the right ingester at 0 index, assignedGroups length', controllerToIngesters[_controllerAddress][ingesterIndexToRemove].assignedGroups.length);


        uint ingesterAddressesIndexToRemove = ingesterToController[_ingesterAddress].ingesterAddressesIndex;
        // Remove ingester from the list
        if (ingesterAddressesIndexToRemove != ingesterCount - 1) {
            address lastIngesterAddress = ingesterAddresses[ingesterCount - 1];
            ingesterAddresses[ingesterAddressesIndexToRemove] = lastIngesterAddress;
            ingesterToController[lastIngesterAddress].ingesterAddressesIndex = ingesterAddressesIndexToRemove;
        }
        ingesterAddresses.pop();
        --ingesterCount;

        // if this was the only ingester registered with this controller, remove their ingester role
        uint numIngestersPerController = controllerToIngesters[_controllerAddress].length;
        if (numIngestersPerController == 1) {
            revokeRole("INGESTER_ROLE", _ingesterAddress);
            revokeRole("CONTROLLER_ROLE", _controllerAddress);
            ingesterProxy.removeIngesterFromGroups(ingesterAssignedGroups, _ingesterAddress);

            // Remove Ingester from Cluster
            uint256 clusterId = controllerToIngesters[_controllerAddress][ingesterIndexToRemove].clusterId;
            ingesterProxy.removeIngesterFromCluster(_ingesterAddress, clusterId, ingesterAssignedGroups);
            // Remove ingester mappings
            delete controllerToIngesters[_controllerAddress];
            delete ingesterToController[_ingesterAddress];
        } else if (numIngestersPerController > 1) {
            //if there is more ingesters for this controller, only remove the desired ingester
            revokeRole("INGESTER_ROLE", _ingesterAddress);

            ingesterProxy.removeIngesterFromGroups(ingesterAssignedGroups, _ingesterAddress);

            //Remove Ingester from Cluster
            uint256 clusterId = controllerToIngesters[_controllerAddress][ingesterIndexToRemove].clusterId;
            ingesterProxy.removeIngesterFromCluster(_ingesterAddress, clusterId, ingesterAssignedGroups);

            // Remove ingester from the controllerToIngesters list
            if (ingesterIndexToRemove != numIngestersPerController - 1) {
                Ingester memory ingester = controllerToIngesters[_controllerAddress][numIngestersPerController - 1];
                controllerToIngesters[_controllerAddress][ingesterIndexToRemove] = ingester;
                //update index of ingester that was moved
                ingesterToController[ingester.ingesterAddress].ingesterAddressesIndex = ingesterIndexToRemove;
            }
            controllerToIngesters[_controllerAddress].pop();
            delete ingesterToController[_ingesterAddress];
        }
        console.log("amount of groups to re-allocate within registration contract", ingesterAssignedGroups.length);
        ingesterProxy.distributeGroupPostUnregistration(ingesterAssignedGroups);
    }

    function isRegisteredIngester(address ingesterAddress) public view returns (bool) {
        return hasRole(INGESTER_ROLE, ingesterAddress);
    }

    function isRegisteredController(address _controllerAddress) public view returns (bool) {
        return hasRole(CONTROLLER_ROLE, _controllerAddress);
    }

    /**
    @notice Calculates the keccak256 hash of the given input parameters.
    @dev This function is used for generating the message hash for signature verification.
    @param _address The address used for hashing.
    @param _value The string value used for hashing.
    @param _nonce The nonce used for hashing.
    @return hash The keccak256 hash of the input parameters.
    */
    function _hash(address _address, string calldata _value, uint256 _nonce) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(_address, _value, _nonce));
    }

    /**
    * @notice Recovers the signer's address from a signed message hash.
    * @dev Utilizes ECDSA to recover the address.
    * @param messageHash The signed message hash.
    * @param sig The signature provided by the signer.
    * @return address The recovered address of the signer.
    */
    function recover(bytes32 messageHash, bytes calldata sig) internal pure returns (address){
        return ECDSA.recover(messageHash, sig);
    }

    /**
    @notice Calculates the Ethereum signed message hash of the given message hash.
    @dev This function is used for converting the message hash into a format that is used for signature verification in Ethereum.
    @param _messageHash The message hash to be converted into an Ethereum signed message hash.
    @return hash The Ethereum signed message hash of the given message hash.
    */
    function getEthSignedMessageHash(
        bytes32 _messageHash
    ) internal pure returns (bytes32) {
        /*
        Signature is produced by signing a keccak256 hash with the following format:
        "\x19Ethereum Signed Message\n" + len(msg) + msg
        */
        return
            keccak256(
                abi.encodePacked("\x19Ethereum Signed Message:\n32", _messageHash)
            );
    }

    //Getter and Setters
    function getIngester(address _ingesterAddress) external view returns (Ingester memory) {
        require(ingesterToController[_ingesterAddress].controllerAddress != address(0), "Ingester does not exist.");
        address controller = ingesterToController[_ingesterAddress].controllerAddress;
        uint ingesterIndex = ingesterToController[_ingesterAddress].ingesterIndex;
        return controllerToIngesters[controller][ingesterIndex];
    }

    function setIngesterDetails(Ingester calldata _ingester, address _ingesterAddress) external returns (Ingester memory) {
        require(ingesterToController[_ingesterAddress].controllerAddress != address(0), "Ingester does not exist.");
        address controller = ingesterToController[_ingesterAddress].controllerAddress;
        uint ingesterIndex = ingesterToController[_ingesterAddress].ingesterIndex;
        controllerToIngesters[controller][ingesterIndex] = _ingester;
        emit IIngesterRegistration.IngesterAssignedGroupsUpdated(_ingesterAddress, _ingester.assignedGroups);
    }

    function addAssignedGroupToIngester(address _ingesterAddress, string calldata _groupUsername) external onlyIngesterProxy returns (uint256) {
        address controller = ingesterToController[_ingesterAddress].controllerAddress;
        uint ingesterIndex = ingesterToController[_ingesterAddress].ingesterIndex;
        controllerToIngesters[controller][ingesterIndex].assignedGroups.push(_groupUsername);
        emit IIngesterRegistration.AssignGroupToIngester(_ingesterAddress, _groupUsername);
        return controllerToIngesters[controller][ingesterIndex].assignedGroups.length - 1;
    }

    function getIngesterToController(address _ingesterAddresses) external view returns (IngesterToController memory) {
        return ingesterToController[_ingesterAddresses];
    }

    function getIngesterAddressFromIndex(uint256 index) external view returns (address) {
        return ingesterAddresses[index];
    }

    function getIngesterCount() external view returns (uint256) {
        return ingesterCount;
    }

    function moveIngesterAssignedGroup(address _ingesterAddress, uint256 assignedGroupsIngesterIndex) external onlyIngesterProxy {
        address controller = ingesterToController[_ingesterAddress].controllerAddress;
        uint ingesterIndex = ingesterToController[_ingesterAddress].ingesterIndex;
        uint256 ingesterAssignedGroupsLength = controllerToIngesters[controller][ingesterIndex].assignedGroups.length;
        // replace last index with group that needs to be removed
        string memory groupToMove = controllerToIngesters[controller][ingesterIndex].assignedGroups[ingesterAssignedGroupsLength-1];
        string memory groupToRemove = controllerToIngesters[controller][ingesterIndex].assignedGroups[assignedGroupsIngesterIndex];
        controllerToIngesters[controller][ingesterIndex].assignedGroups[assignedGroupsIngesterIndex] = groupToMove;
        controllerToIngesters[controller][ingesterIndex].assignedGroups.pop();
    }
}
