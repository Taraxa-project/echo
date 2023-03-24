// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.14;

import '../interfaces/IngesterOrchestratorV1/IIngesterRegistration.sol';
import './IngesterRegistryAccessControl.sol';
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

/**
 * @title IngesterRegistrationV2
 * @dev This contract handles the registration, verification, and storage of ingesters.
 */
contract IngesterRegistration is IIngesterRegistration, IngesterRegistryAccessControl {

    mapping(address => IIngesterRegistration.Ingester[]) public _ingesters;
    mapping(address => IIngesterRegistration.IngesterToController) public _registeredIngesterToController;
    uint public _ingesterCount;

    /**
     * @notice Retrieves the ingester details based on the given address.
     * @param ingesterAddress The address of the ingester.
     * @return The Ingester struct containing ingester details.
     */
    function getIngester(address ingesterAddress) public view returns (IIngesterRegistration.Ingester memory) {
        address controller = _registeredIngesterToController[ingesterAddress].controllerAddress;
        return _ingesters[controller][_registeredIngesterToController[ingesterAddress].ingesterIndex];
    }

    /**
    * @notice Retrieves the ingester information for a given ingester address.
    * @dev Requires the ingester to be registered with a controller address.
    * @param ingesterAddress The address of the ingester to be retrieved.
    * @return Ingester memory structure containing the ingester's data.
    */
    function _hash(address _address, string memory _value, uint256 _nonce) public pure override returns (bytes32) {
        return keccak256(abi.encodePacked(_address, _value, _nonce));
    }

    /**
    * @notice Recovers the signer's address from a signed message hash.
    * @dev Utilizes ECDSA to recover the address.
    * @param messageHash The signed message hash.
    * @param sig The signature provided by the signer.
    * @return The recovered address of the signer.
    */
    function recover(bytes32 messageHash, bytes memory sig) public pure override returns (address){
        return ECDSA.recover(messageHash, sig);
    }

    /**
    * @notice Registers an ingester with a controller address.
    * @dev Requires a valid signature and ensures the ingester is not already registered.
    * @param ingesterAddress The address of the ingester to be registered.
    * @param message The message used for signature verification.
    * @param nonce The nonce used for signature verification.
    * @param sig The signature provided by the ingester.
    */
    function getEthSignedMessageHash(
        bytes32 _messageHash
    ) public pure override returns (bytes32) {
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
        string memory message,
        uint256 nonce,
        bytes memory sig
    ) external override {
        // require(_ingesters[msg.sender][_registeredIngesterToController[ingesterAddress].ingesterIndex].verified != true, "Ingestor already verified.");
        require(_registeredIngesterToController[ingesterAddress].controllerAddress != msg.sender, "Ingestor already registered.");

        bytes32 messageHash = _hash(ingesterAddress, message, nonce);

        bytes32 ethSignedMessageHash = getEthSignedMessageHash(messageHash);

        require(ECDSA.recover(ethSignedMessageHash, sig) == ingesterAddress, "Invalid signature.");

        Ingester memory ingester = IIngesterRegistration.Ingester(ingesterAddress, true, new string[](0));

        _ingesters[msg.sender].push(ingester);
        _registeredIngesterToController[ingesterAddress].controllerAddress = msg.sender;
        _registeredIngesterToController[ingesterAddress].ingesterIndex = _ingesters[msg.sender].length - 1;

        _grantRole(INGESTER_ROLE, msg.sender);

        _ingesterCount++;

        emit IIngesterRegistration.IngesterRegistered(msg.sender, ingesterAddress);
    }

    /**
    * @notice Unregisters an ingester from its controller address.
    * @dev Requires the caller to have the registered ingester role and be the controller of the ingester.
    * @param ingesterAddress The address of the ingester to be unregistered.
    * @param originCaller The original caller address to unregister the ingester.
    * @return groups An array of strings containing the assigned groups of the unregistered ingester.
    */
    function unRegisteringIngester(address ingesterAddress, address originCaller) public onlyRegistered returns (string[] memory assignedGroups) {
        require(_registeredIngesterToController[ingesterAddress].controllerAddress == msg.sender, "Ingestor is not registered with this controller address.");

        _registeredIngesterToController[ingesterAddress].controllerAddress = address(0);
        uint ingesterIndex = _registeredIngesterToController[ingesterAddress].ingesterIndex;

        delete _ingesters[originCaller][ingesterIndex]; // delete ingester 

        _registeredIngesterToController[ingesterAddress] = IIngesterRegistration.IngesterToController(address(0), 0); // delete controller from ingester

        // if this was the only ingester registered with this controller, remove their ingester role
        if (_ingesters[originCaller].length > 0) {
            renounceRole("INGESTER_ROLE", originCaller);
        }

        _ingesterCount--;
        
        emit IIngesterRegistration.IngesterUnRegistered(originCaller, ingesterAddress);
        return _ingesters[originCaller][ingesterIndex].assignedGroups;
    }
}