// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import { LibAppStorageTest, AppStorageTest } from  "../libraries/LibAppStorageUpgradeTest.sol";
import "../../interfaces/IIngesterRegistration.sol";
import "@solidstate/contracts/cryptography/ECDSA.sol";
import "./AccessControlFacetTest.sol";
import "./CommonFunctionsFacetTest.sol";


contract RegistryFacetTest is IIngesterRegistration, AccessControlFacetTest, CommonFunctionsFacetTest {

    function getIngester(address ingesterAddress) public view override returns (IIngesterRegistration.Ingester memory) {
        IIngesterRegistration.Ingester memory ingester = Ingester(ingesterAddress, false, 999);
        return ingester;
    }

     /**
    * @notice Registers a new ingester with the corresponding controller address.
    * @dev Can only be called by a registered controller.
    * @param ingesterAddress The address of the ingester to be registered.
    * @param message The message containing ingester and controller addresses.
    * @param nonce The nonce used to generate the signature.
    * @param sig The signature proving the ingester's consent for registration.
    */
    function registerIngester(
        address ingesterAddress, 
        string calldata message,
        uint256 nonce,
        bytes calldata sig
        ) external {
        address controllerAddress = msg.sender;
        require(s.ingesterToController[ingesterAddress].controllerAddress != controllerAddress, "Ingester already registered.");
       
        bytes32 messageHash = hash(ingesterAddress, message, nonce);

        bytes32 ethSignedMessageHash = getEthSignedMessageHash(messageHash);

        require(ECDSA.recover(ethSignedMessageHash, sig) == controllerAddress, "Invalid signature.");
        
        _grantRole(LibAppStorageTest.INGESTER_ROLE, ingesterAddress);
        _grantRole(LibAppStorageTest.CONTROLLER_ROLE, controllerAddress);

        Ingester memory ingester = IIngesterRegistration.Ingester(ingesterAddress, false, 0);

        s.controllerToIngesters[controllerAddress].push(ingester);

        s.ingesterAddresses.push(ingesterAddress);
        s.ingesterToController[ingesterAddress] = IIngesterRegistration.IngesterToController(controllerAddress, s.controllerToIngesters[controllerAddress].length - 1, s.ingesterAddresses.length - 1);

        LibAppStorageTest.addIngesterToCluster(ingesterAddress, controllerAddress);

        emit IIngesterRegistration.IngesterRegistered(controllerAddress, ingesterAddress);
    }

    /**
    @notice Calculates the keccak256 hash of the given input parameters.
    @dev This function is used for generating the message hash for signature verification.
    @param _address The address used for hashing.
    @param _value The string value used for hashing.
    @param _nonce The nonce used for hashing.
    @return hash The keccak256 hash of the input parameters.
    */
    function hash(address _address, string calldata _value, uint256 _nonce) public pure returns (bytes32) {
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
    * @notice Unregisters an ingester and removes its association with the controller.
    * @dev Can only be called by a registered controller.
    * @param ingesterAddress The address of the ingester to be unregistered.
    */
    function unRegisterIngester(address ingesterAddress) external onlyRegisteredController {
        address controllerAddress = msg.sender;
        require(s.ingesterToController[ingesterAddress].controllerAddress != address(0), "Ingester does not exist");
        require(s.ingesterToController[ingesterAddress].controllerAddress == controllerAddress, "Controllers address does not match ingesters address.");

        uint256 ingesterIndexToRemove = s.ingesterToController[ingesterAddress].ingesterIndex;
        uint256 clusterId = s.controllerToIngesters[controllerAddress][ingesterIndexToRemove].clusterId;
        uint ingesterAddressesIndexToRemove = s.ingesterToController[ingesterAddress].ingesterAddressesIndex;
        
        removeIngesterFromIngesterAddresses(ingesterAddressesIndexToRemove);
        removeIngesterFromControllerMapping(ingesterIndexToRemove, controllerAddress);
        removeIngesterFromIngesterMapping(ingesterAddress);

        uint numIngestersPerController = s.controllerToIngesters[controllerAddress].length;
        if (numIngestersPerController == 0) {
            _revokeRole("CONTROLLER_ROLE", controllerAddress);
            delete s.controllerToIngesters[controllerAddress];
        }
        
        LibAppStorageTest.removeIngesterFromCluster(ingesterAddress, clusterId);
        emit IIngesterRegistration.IngesterUnRegistered(controllerAddress, ingesterAddress);
    }  

    function removeIngesterFromIngesterAddresses(uint256 ingesterAddressesIndexToRemove) internal {
        uint256 ingesterCount = s.ingesterAddresses.length;
        if (ingesterAddressesIndexToRemove != ingesterCount - 1) {
            address lastIngesterAddress = s.ingesterAddresses[ingesterCount - 1];
            s.ingesterAddresses[ingesterAddressesIndexToRemove] = lastIngesterAddress;
            s.ingesterToController[lastIngesterAddress].ingesterAddressesIndex = ingesterAddressesIndexToRemove;
        }
        s.ingesterAddresses.pop();
    } 

    function removeIngesterFromControllerMapping(uint256 ingesterIndexToRemove, address controllerAddress) internal {
        uint numIngestersPerController = s.controllerToIngesters[controllerAddress].length;

        if (ingesterIndexToRemove != numIngestersPerController - 1) {
            Ingester memory ingester = s.controllerToIngesters[controllerAddress][numIngestersPerController - 1];
            s.controllerToIngesters[controllerAddress][ingesterIndexToRemove] = ingester;
            s.ingesterToController[ingester.ingesterAddress].ingesterIndex = ingesterIndexToRemove;
        }
        s.controllerToIngesters[controllerAddress].pop();
    }

    function removeIngesterFromIngesterMapping(address ingesterAddress) internal {
        _revokeRole("INGESTER_ROLE", ingesterAddress);
        delete s.ingesterToController[ingesterAddress];
    }

}
