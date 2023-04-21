// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.14;

import '../interfaces/IngesterOrchestratorV2/IIngesterRegistrationV2.sol';
import './IngesterRegistryAccessControlV2.sol';
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";


/**
 * @title IngesterRegistrationV2
 * @dev This contract handles the registration, verification, and storage of ingesters.
 */
contract IngesterRegistrationV2 is IIngesterRegistrationV2, IngesterRegistryAccessControlV2 {

    mapping(address => IIngesterRegistrationV2.Ingester[]) internal _ingesters;
    mapping(address => IIngesterRegistrationV2.IngesterToController) internal _registeredIngesterToController;
    address[] public _ingesterAddresses;
    uint public _ingesterCount;

    /**
     * @notice Retrieves the ingester details based on the given address.
     * @param ingesterAddress The address of the ingester.
     * @return Ingester The Ingester struct containing ingester details.
     */
    function getIngester(address ingesterAddress) public view returns (IIngesterRegistrationV2.Ingester memory) {
        require(_registeredIngesterToController[ingesterAddress].controllerAddress != address(0), "Ingester does not exist.");
        address controller = _registeredIngesterToController[ingesterAddress].controllerAddress;
        return _ingesters[controller][_registeredIngesterToController[ingesterAddress].ingesterIndex];
    }

    /**
    @notice Calculates the keccak256 hash of the given input parameters.
    @dev This function is used for generating the message hash for signature verification.
    @param _address The address used for hashing.
    @param _value The string value used for hashing.
    @param _nonce The nonce used for hashing.
    @return hash The keccak256 hash of the input parameters.
    */
    function _hash(address _address, string calldata _value, uint256 _nonce) public pure override returns (bytes32) {
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
    * @notice Registers an ingester with a controller address.
    * @dev Requires a valid signature and ensures the ingester is not already registered.
    * @param ingesterAddress The address of the ingester to be registered.
    * @param message The message used for signature verification.
    * @param nonce The nonce used for signature verification.
    * @param sig The signature provided by the ingester.
    */
    function registerIngester(
        address ingesterAddress,
        string calldata message,
        uint256 nonce,
        bytes calldata sig
    ) external override {
        require(_registeredIngesterToController[ingesterAddress].controllerAddress != msg.sender, "Ingestor already registered.");

        bytes32 messageHash = _hash(ingesterAddress, message, nonce);

        bytes32 ethSignedMessageHash = getEthSignedMessageHash(messageHash);

        require(ECDSA.recover(ethSignedMessageHash, sig) == ingesterAddress, "Invalid signature.");

        Ingester memory ingester = IIngesterRegistrationV2.Ingester(ingesterAddress, true, new string[](0));

        _ingesters[msg.sender].push(ingester);
        _registeredIngesterToController[ingesterAddress].controllerAddress = msg.sender;
        _registeredIngesterToController[ingesterAddress].ingesterIndex = _ingesters[msg.sender].length - 1;
        _ingesterAddresses.push(ingesterAddress);
        _registeredIngesterToController[ingesterAddress].ingesterAddressesIndex  = _ingesterAddresses.length - 1;

        _grantRole(INGESTER_ROLE, msg.sender);

        _ingesterCount++;

        emit IIngesterRegistrationV2.IngesterRegistered(msg.sender, ingesterAddress);
    }

    /**
    * @notice Unregisters an ingester from its controller address.
    * @dev Requires the caller to have the registered ingester role and be the controller of the ingester.
    * @param ingesterAddress The address of the ingester to be unregistered.
    * @param originCaller The original caller address to unregister the ingester.
    * @return groups An array of strings containing the assigned groups of the unregistered ingester.
    */
    function unRegisteringIngester(address ingesterAddress, address originCaller) public onlyRegistered returns (string[] memory groups) {
        require(_registeredIngesterToController[ingesterAddress].controllerAddress == msg.sender, "Ingestor is not registered with this controller address.");

        _registeredIngesterToController[ingesterAddress].controllerAddress = address(0);
        uint ingesterIndex = _registeredIngesterToController[ingesterAddress].ingesterIndex;
        string[] memory assignedGroups = _ingesters[originCaller][ingesterIndex].assignedGroups;

        delete _ingesterAddresses[_registeredIngesterToController[ingesterAddress].ingesterAddressesIndex];
        delete _ingesters[originCaller][ingesterIndex]; 

        _registeredIngesterToController[ingesterAddress] = IIngesterRegistrationV2.IngesterToController(address(0), 0, 0); // delete controller from ingester

        // if this was the only ingester registered with this controller, remove their ingester role
        if (_ingesters[originCaller].length > 0) {
            renounceRole("INGESTER_ROLE", originCaller);
        }

        _ingesterCount--;
        
        emit IIngesterRegistrationV2.IngesterUnRegistered(originCaller, ingesterAddress);
        return assignedGroups;
    }
}