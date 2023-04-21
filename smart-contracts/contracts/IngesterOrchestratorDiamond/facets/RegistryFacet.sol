// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { LibAppStorage, AppStorage } from  "../libraries/LibAppStorage.sol";
import "../interfaces/IIngesterRegistration.sol";
import "@solidstate/contracts/cryptography/ECDSA.sol";
import "@solidstate/contracts/access/access_control/AccessControl.sol";
import "./AccessControlFacet.sol";


contract RegistryFacet is IIngesterRegistration, AccessControlFacet {

    function registerIngester(
        address ingesterAddress, 
        address controllerAddress,
        string calldata message,
        uint256 nonce,
        bytes calldata sig
        ) external {
        AppStorage storage s = LibAppStorage.appStorage();

        require(s.ingesterToController[ingesterAddress].controllerAddress != controllerAddress, "Ingester already exists");
       
        bytes32 messageHash = hash(ingesterAddress, message, nonce);

        bytes32 ethSignedMessageHash = getEthSignedMessageHash(messageHash);

        require(ECDSA.recover(ethSignedMessageHash, sig) == controllerAddress, "Invalid signature.");
        
        //slither possible re-rentrancy attack. Making an external call before modifying contract storage
        //this is a closed loop without sending eth around. IngesterProxy is fixed unless owner of contracts is taken over
        // is this still a risk? I will always have to change the ingester storage clusterId after external call
        uint256 clusterId = LibAppStorage.addIngesterToCluster(ingesterAddress, controllerAddress);

        Ingester memory ingester = IIngesterRegistration.Ingester(ingesterAddress, true, clusterId);

        s.controllerToIngesters[controllerAddress].push(ingester);

        s.ingesterAddresses.push(ingesterAddress);
        s.ingesterToController[ingesterAddress] = IIngesterRegistration.IngesterToController(controllerAddress, s.controllerToIngesters[controllerAddress].length - 1, s.ingesterAddresses.length - 1);
        ++s.ingesterCount;

        _grantRole(LibAppStorage.INGESTER_ROLE, ingesterAddress);
        _grantRole(LibAppStorage.CONTROLLER_ROLE, controllerAddress);

        emit IIngesterRegistration.IngesterRegistered(controllerAddress, ingesterAddress);
    }

    function hash(address _address, string calldata _value, uint256 _nonce) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(_address, _value, _nonce));
    }

    function recover(bytes32 messageHash, bytes calldata sig) internal pure returns (address){
        return ECDSA.recover(messageHash, sig);
    }

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

    function getIngester(address ingesterAddress) external view returns (Ingester memory) {
        AppStorage storage s = LibAppStorage.appStorage();

        require(s.ingesterToController[ingesterAddress].controllerAddress != address(0), "Ingester does not exist.");
        address controller = s.ingesterToController[ingesterAddress].controllerAddress;
        uint ingesterIndex = s.ingesterToController[ingesterAddress].ingesterIndex;

        return s.controllerToIngesters[controller][ingesterIndex];
    }
}
