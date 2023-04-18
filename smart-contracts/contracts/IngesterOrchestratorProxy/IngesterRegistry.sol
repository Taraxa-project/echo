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

    mapping(address => Ingester[]) private _controllerToIngesters;
    mapping(address => IngesterToController) private _ingesterToController;
    address[] private _ingesterAddresses;
    uint private _ingesterCount;


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

    function setIngesterProxy(address _ingesterProxyAddress) external onlyAdmin {
        ingesterProxyAddress = _ingesterProxyAddress;
        ingesterProxy = IngesterProxy(_ingesterProxyAddress);
        _setupRole(DEFAULT_ADMIN_ROLE, _ingesterProxyAddress);
    }

    /**
    * @notice Registers a new ingester with the corresponding controller address.
    * @dev Can only be called by a registered controller.
    * @param ingesterAddress The address of the ingester to be registered.
    * @param controllerAddress The address of the controller registering the ingester.
    * @param message The message containing ingester and controller addresses.
    * @param nonce The nonce used to generate the signature.
    * @param sig The signature proving the ingester's consent for registration.
    */
    function registerIngester(
        address ingesterAddress, 
        address controllerAddress,
        string calldata message,
        uint256 nonce,
        bytes calldata sig
        ) external onlyIngesterProxy {
        require(_ingesterToController[ingesterAddress].controllerAddress != controllerAddress, "Ingester already exists");
       
        bytes32 messageHash = _hash(ingesterAddress, message, nonce);

        bytes32 ethSignedMessageHash = getEthSignedMessageHash(messageHash);

        require(ECDSA.recover(ethSignedMessageHash, sig) == ingesterAddress, "Invalid signature.");
        
        //add the ingester to an available cluster
        //return the cluster it was added and add that to ingester structure
        uint256 clusterId = ingesterProxy.addIngesterToCluster(ingesterAddress, controllerAddress);

        Ingester memory ingester = IIngesterRegistration.Ingester(ingesterAddress, true, clusterId, new string[](0));

        _controllerToIngesters[controllerAddress].push(ingester);

        _ingesterAddresses.push(ingesterAddress);
        _ingesterToController[ingesterAddress] = IIngesterRegistration.IngesterToController(controllerAddress, _controllerToIngesters[controllerAddress].length - 1, _ingesterAddresses.length - 1);
        ++_ingesterCount;


        _grantRole(INGESTER_ROLE, ingesterAddress);
        _grantRole(CONTROLLER_ROLE, controllerAddress);

        emit IIngesterRegistration.IngesterRegistered(controllerAddress, ingesterAddress);
    }

    /**
    * @notice Unregisters an ingester and removes its association with the controller.
    * @dev Can only be called by a registered controller.
    * @param ingesterAddress The address of the ingester to be unregistered.
    * @param controllerAddress The address of the controller unregistering the ingester.
    */
    function unRegisterIngester(address ingesterAddress, address controllerAddress) external onlyIngesterProxy {
        require(_ingesterToController[ingesterAddress].controllerAddress == controllerAddress, "Ingester does not exist");
        uint256 ingesterIndexToRemove = _ingesterToController[ingesterAddress].ingesterIndex;
        string[] memory ingesterAssignedGroups = _controllerToIngesters[controllerAddress][ingesterIndexToRemove].assignedGroups;


        uint ingesterAddressesIndexToRemove = _ingesterToController[ingesterAddress].ingesterAddressesIndex;
        // Remove ingester from the list
        if (ingesterAddressesIndexToRemove != _ingesterCount - 1) {
            address lastIngesterAddress = _ingesterAddresses[_ingesterCount - 1];
            _ingesterAddresses[ingesterAddressesIndexToRemove] = lastIngesterAddress;
            _ingesterToController[lastIngesterAddress].ingesterAddressesIndex = ingesterAddressesIndexToRemove;
        }
        _ingesterAddresses.pop();
        --_ingesterCount;

        // if this was the only ingester registered with this controller, remove their ingester role
        uint numIngestersPerController = _controllerToIngesters[controllerAddress].length;
        uint256 clusterId = 0;
        if (numIngestersPerController == 1) {
            revokeRole("INGESTER_ROLE", ingesterAddress);
            revokeRole("CONTROLLER_ROLE", controllerAddress);
            ingesterProxy.removeIngesterFromGroups(ingesterAssignedGroups, ingesterAddress);

            // Remove Ingester from Cluster
            clusterId = _controllerToIngesters[controllerAddress][ingesterIndexToRemove].clusterId;
            ingesterProxy.removeIngesterFromCluster(ingesterAddress, clusterId);
            // Remove ingester mappings
            delete _controllerToIngesters[controllerAddress];
            delete _ingesterToController[ingesterAddress];
        } else if (numIngestersPerController > 1) {
            //if there is more ingesters for this controller, only remove the desired ingester
            revokeRole("INGESTER_ROLE", ingesterAddress);

            ingesterProxy.removeIngesterFromGroups(ingesterAssignedGroups, ingesterAddress);

            //Remove Ingester from Cluster
            clusterId = _controllerToIngesters[controllerAddress][ingesterIndexToRemove].clusterId;
            ingesterProxy.removeIngesterFromCluster(ingesterAddress, clusterId);

            // Remove ingester from the _controllerToIngesters list
            if (ingesterIndexToRemove != numIngestersPerController - 1) {
                Ingester memory ingester = _controllerToIngesters[controllerAddress][numIngestersPerController - 1];
                _controllerToIngesters[controllerAddress][ingesterIndexToRemove] = ingester;
                //update index of ingester that was moved
                _ingesterToController[ingester.ingesterAddress].ingesterAddressesIndex = ingesterIndexToRemove;
            }
            _controllerToIngesters[controllerAddress].pop();
            delete _ingesterToController[ingesterAddress];
        }
        
        ingesterProxy.distributeGroupPostUnregistration(ingesterAssignedGroups, clusterId);
    }

    /**
    * @notice Checks if an address is a registered ingester.
    * @param ingesterAddress The address to check for ingester registration.
    * @return A boolean indicating if the address is a registered ingester.
    */
    function isRegisteredIngester(address ingesterAddress) public view returns (bool) {
        return hasRole(INGESTER_ROLE, ingesterAddress);
    }

    /**
    * @notice Checks if an address is a registered controller.
    * @param _controllerAddress The address to check for controller registration.
    * @return A boolean indicating if the address is a registered controller.
    */
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

    /**
    * @notice Retrieves the details of a registered ingester.
    * @param _ingesterAddress The address of the registered ingester.
    * @return An Ingester struct containing the ingester's details.
    */
    function getIngester(address _ingesterAddress) external view returns (Ingester memory) {
        require(_ingesterToController[_ingesterAddress].controllerAddress != address(0), "Ingester does not exist.");
        address controller = _ingesterToController[_ingesterAddress].controllerAddress;
        uint ingesterIndex = _ingesterToController[_ingesterAddress].ingesterIndex;
        return _controllerToIngesters[controller][ingesterIndex];
    }

    /**
    * @notice Assigns a group to an ingester.
    * @dev Can only be called by the IngesterProxy contract.
    * @param _ingesterAddress The address of the ingester to be assigned the group.
    * @param _groupUsername The group's username to be assigned.
    * @return The new number of groups assigned to the ingester.
    */
    function addAssignedGroupToIngester(address _ingesterAddress, string calldata _groupUsername) external onlyIngesterProxy returns (uint256) {
        address controller = _ingesterToController[_ingesterAddress].controllerAddress;
        uint ingesterIndex = _ingesterToController[_ingesterAddress].ingesterIndex;
        _controllerToIngesters[controller][ingesterIndex].assignedGroups.push(_groupUsername);
        emit IIngesterRegistration.AssignGroupToIngester(_ingesterAddress, _groupUsername);
        return _controllerToIngesters[controller][ingesterIndex].assignedGroups.length - 1;
    }

    /**
    * @notice Retrieves the controller information for an ingester.
    * @param ingesterAddresses The address of the ingester.
    * @return An IngesterToController struct containing the controller's information.
    */
    function getIngesterToController(address ingesterAddresses) external view returns (IIngesterRegistration.IngesterToController memory) {
        return _ingesterToController[ingesterAddresses];
    }

    /**
    * @notice Retrieves the ingester address from the ingester index.
    * @param index The index of the ingester in the ingesters list.
    * @return address of the ingester corresponding to the provided index.
    */
    function getIngesterAddressFromIndex(uint256 index) external view returns (address) {
        return _ingesterAddresses[index];
    }

    /**
    * @notice Retrieves the list of ingesters for a given controller.
    * @param controllerAddress The address of the controller.
    * @return An array of Ingester structs containing the details of
    */
    function getControllerIngesters(address controllerAddress) external view returns (IIngesterRegistration.Ingester[] memory) {
        return _controllerToIngesters[controllerAddress];
    }

    /**
    * @notice Returns the total number of ingesters registered in the contract.
    * @dev This is a view function and doesn't modify the state of the contract.
    * @return _ingesterCount A uint256 representing the total number of ingesters.
    */
    function getIngesterCount() external view returns (uint256) {
        return _ingesterCount;
    }

    /**
    * @notice Moves an ingester's assigned group within the assignedGroups array.
    * @dev This function can only be called by the IngesterProxy.
    * @param _ingesterAddress The address of the ingester.
    * @param assignedGroupsIngesterIndex The index of the assigned group to be moved within the assignedGroups array.
    */
    function moveIngesterAssignedGroup(address _ingesterAddress, uint256 assignedGroupsIngesterIndex) external onlyIngesterProxy {
        address controller = _ingesterToController[_ingesterAddress].controllerAddress;
        uint ingesterIndex = _ingesterToController[_ingesterAddress].ingesterIndex;
        uint256 ingesterAssignedGroupsLength = _controllerToIngesters[controller][ingesterIndex].assignedGroups.length;
        // replace last index with group that needs to be removed
        string memory groupToMove = _controllerToIngesters[controller][ingesterIndex].assignedGroups[ingesterAssignedGroupsLength-1];
        _controllerToIngesters[controller][ingesterIndex].assignedGroups[assignedGroupsIngesterIndex] = groupToMove;
        _controllerToIngesters[controller][ingesterIndex].assignedGroups.pop();
    }
}
