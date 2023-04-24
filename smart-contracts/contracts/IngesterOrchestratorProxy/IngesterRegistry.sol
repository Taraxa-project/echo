// SPDX-License-Identifier: MIT
pragma solidity 0.8.14;

import "@openzeppelin/contracts/access/AccessControlEnumerable.sol";
import "../interfaces/IngesterOrchestratorProxy/IIngesterGroupManager.sol";
import "../interfaces/IngesterOrchestratorProxy/IIngesterRegistration.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import './IngesterProxy.sol';


contract IngesterRegistry is AccessControlEnumerable, IIngesterRegistration {
    bytes32 public constant INGESTER_ROLE = keccak256("INGESTER_ROLE");
    bytes32 public constant CONTROLLER_ROLE = keccak256("CONTROLLER_ROLE");

    address public ingesterProxyAddress;
    IngesterProxy private _ingesterProxy;

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

    /**
    * @notice Updates the address of the IngesterProxy contract.
    * @param newIngesterProxy The address of the new IngesterProxy contract.
    */
    function updateIngesterProxy(address newIngesterProxy) external onlyAdmin {
        require(newIngesterProxy != address(0), "New ingester proxy address cannot be a zero address.");
        ingesterProxyAddress = newIngesterProxy;
        _ingesterProxy = IngesterProxy(newIngesterProxy);
        _setupRole(DEFAULT_ADMIN_ROLE, newIngesterProxy);
        emit IIngesterRegistration.IngesterProxyAddressUpdated(newIngesterProxy);
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

        require(ECDSA.recover(ethSignedMessageHash, sig) == controllerAddress, "Invalid signature.");
        
        //slither possible re-rentrancy attack. Making an external call before modifying contract storage
        //this is a closed loop without sending eth around. IngesterProxy is fixed unless owner of contracts is taken over
        // is this still a risk? I will always have to change the ingester storage clusterId after external call
        uint256 clusterId = _ingesterProxy.addIngesterToCluster(ingesterAddress, controllerAddress);

        Ingester memory ingester = IIngesterRegistration.Ingester(ingesterAddress, true, clusterId);

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
        uint256 clusterId = _controllerToIngesters[controllerAddress][ingesterIndexToRemove].clusterId;
        string[] memory ingesterAssignedGroups = _ingesterProxy.getIngesterAssignedGroups(ingesterAddress, clusterId);


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
        if (numIngestersPerController == 1) {
            revokeRole("INGESTER_ROLE", ingesterAddress);
            revokeRole("CONTROLLER_ROLE", controllerAddress);
            
            // Remove ingester mappings
            delete _controllerToIngesters[controllerAddress];
            delete _ingesterToController[ingesterAddress];
            
            //slither possible re-rentrancy attack. Making an external call before modifying contract storage
            //this is a closed loop without sending eth around. IngesterProxy is fixed unless owner of contracts is taken over
            // is this still a risk? I will always have to change the ingester storage clusterId after external call
            _ingesterProxy.removeIngesterFromGroups(clusterId, ingesterAddress);

            // Remove Ingester from Cluster
            _ingesterProxy.removeIngesterFromCluster(ingesterAddress, clusterId);
        } else if (numIngestersPerController > 1) {
            //if there is more ingesters for this controller, only remove the desired ingester
            revokeRole("INGESTER_ROLE", ingesterAddress);

            // Remove ingester from the _controllerToIngesters list
            if (ingesterIndexToRemove != numIngestersPerController - 1) {
                Ingester memory ingester = _controllerToIngesters[controllerAddress][numIngestersPerController - 1];
                _controllerToIngesters[controllerAddress][ingesterIndexToRemove] = ingester;
                //update index of ingester that was moved
                _ingesterToController[ingester.ingesterAddress].ingesterAddressesIndex = ingesterIndexToRemove;
            }
            _controllerToIngesters[controllerAddress].pop();
            delete _ingesterToController[ingesterAddress];

            _ingesterProxy.removeIngesterFromGroups(clusterId, ingesterAddress);

            //Remove Ingester from Cluster
            _ingesterProxy.removeIngesterFromCluster(ingesterAddress, clusterId);

        }
        
        _ingesterProxy.distributeGroupPostUnregistration(ingesterAssignedGroups, clusterId);
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
    function _hash(address _address, string calldata _value, uint256 _nonce) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked(_address, _value, _nonce));
    }

    /**
    @notice Calculates the keccak256 hash of the given input parameters.
    @dev This function is used for generating the message hash for signature verification.
    @param _address The address used for hashing.
    @param _value The string value used for hashing.
    @param _nonce The nonce used for hashing.
    @return hash The keccak256 hash of the input parameters.
    */
    function hash(address _address, string calldata _value, uint256 _nonce) external pure returns (bytes32) {
        return _hash(_address, _value, _nonce);
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
    * @notice Retrieves the details of a registered ingester including assigned groups.
    * @param ingesterAddress The address of the registered ingester.
    * @return An IngesterWithGroups struct containing the ingester's details and its assigned groups.
    */
    function getIngesterWithGroups(address ingesterAddress) external view returns (IngesterWithGroups memory) {
        require(_ingesterToController[ingesterAddress].controllerAddress != address(0), "Ingester does not exist.");
        address controller = _ingesterToController[ingesterAddress].controllerAddress;
        uint ingesterIndex = _ingesterToController[ingesterAddress].ingesterIndex;
        Ingester memory ingester = _controllerToIngesters[controller][ingesterIndex];

        string[] memory assignedGroups = _ingesterProxy.getIngesterAssignedGroups(ingesterAddress, ingester.clusterId);
        IngesterWithGroups memory ingesterWithAssignedGroups = IngesterWithGroups(
            ingesterAddress,
            ingester.verified,
            ingester.clusterId,
            assignedGroups
        );
        return ingesterWithAssignedGroups;
    }

    /**
    * @notice Retrieves the details of a registered ingester.
    * @param ingesterAddress The address of the registered ingester.
    * @return An Ingester struct containing the ingester's details.
    */
    function getIngester(address ingesterAddress) external view returns (Ingester memory) {
        require(_ingesterToController[ingesterAddress].controllerAddress != address(0), "Ingester does not exist.");
        address controller = _ingesterToController[ingesterAddress].controllerAddress;
        uint ingesterIndex = _ingesterToController[ingesterAddress].ingesterIndex;

        return _controllerToIngesters[controller][ingesterIndex];
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
}
