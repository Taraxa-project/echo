// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { LibAppStorage, AppStorage } from  "../libraries/LibAppStorage.sol";
import "../interfaces/IIngesterRegistration.sol";
import "@solidstate/contracts/cryptography/ECDSA.sol";
import "@solidstate/contracts/access/access_control/AccessControl.sol";
import "./AccessControlFacet.sol";
import "./CommonFunctionsFacet.sol";


contract RegistryFacet is IIngesterRegistration, AccessControlFacet, CommonFunctionsFacet {

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

    function unRegisterIngester(address ingesterAddress) external onlyRegisteredController {

        address controllerAddress = msg.sender;

        require(s.ingesterToController[ingesterAddress].controllerAddress == controllerAddress, "Ingester does not exist");

        uint256 ingesterIndexToRemove = s.ingesterToController[ingesterAddress].ingesterIndex;
        uint256 clusterId = s.controllerToIngesters[controllerAddress][ingesterIndexToRemove].clusterId;
        string[] memory ingesterAssignedGroups = s.ingesterClusters[clusterId].ingesterToAssignedGroups[ingesterAddress];

        uint ingesterAddressesIndexToRemove = s.ingesterToController[ingesterAddress].ingesterAddressesIndex;
        // Remove ingester from the list
        if (ingesterAddressesIndexToRemove != s.ingesterCount - 1) {
            address lastIngesterAddress = s.ingesterAddresses[s.ingesterCount - 1];
            s.ingesterAddresses[ingesterAddressesIndexToRemove] = lastIngesterAddress;
            s.ingesterToController[lastIngesterAddress].ingesterAddressesIndex = ingesterAddressesIndexToRemove;
        }
        s.ingesterAddresses.pop();
        --s.ingesterCount;

        // if this was the only ingester registered with this controller, remove their ingester role
        uint numIngestersPerController = s.controllerToIngesters[controllerAddress].length;
        if (numIngestersPerController == 1) {
            _revokeRole("INGESTER_ROLE", ingesterAddress);
            _revokeRole("CONTROLLER_ROLE", controllerAddress);
            
            // Remove ingester mappings
            delete s.controllerToIngesters[controllerAddress];
            delete s.ingesterToController[ingesterAddress];
            
            //slither possible re-rentrancy attack. Making an external call before modifying contract storage
            //this is a closed loop without sending eth around. IngesterProxy is fixed unless owner of contracts is taken over
            // is this still a risk? I will always have to change the ingester storage clusterId after external call
            LibAppStorage.removeIngesterFromGroups(clusterId, ingesterAddress);

            // Remove Ingester from Cluster
            LibAppStorage.removeIngesterFromCluster(ingesterAddress, clusterId);
        } else if (numIngestersPerController > 1) {
            //if there is more ingesters for this controller, only remove the desired ingester
            _revokeRole("INGESTER_ROLE", ingesterAddress);

            // Remove ingester from the s.controllerToIngesters list
            if (ingesterIndexToRemove != numIngestersPerController - 1) {
                Ingester memory ingester = s.controllerToIngesters[controllerAddress][numIngestersPerController - 1];
                s.controllerToIngesters[controllerAddress][ingesterIndexToRemove] = ingester;
                //update index of ingester that was moved
                s.ingesterToController[ingester.ingesterAddress].ingesterAddressesIndex = ingesterIndexToRemove;
            }
            s.controllerToIngesters[controllerAddress].pop();
            delete s.ingesterToController[ingesterAddress];

            LibAppStorage.removeIngesterFromGroups(clusterId, ingesterAddress);

            //Remove Ingester from Cluster
            LibAppStorage.removeIngesterFromCluster(ingesterAddress, clusterId);

        }
        emit IIngesterRegistration.IngesterUnRegistered(controllerAddress, ingesterAddress);

        //if there is replication and there isn't ingesters live in cluster than add to unallocated groups
        if (s.maxIngestersPerGroup > 1){ 
            if (s.ingesterClusters[clusterId].ingesterAddresses.length == 0) {
                LibAppStorage.AddToUnAllocateGroups(ingesterAssignedGroups);
            }
        } else {
            LibAppStorage.AddToUnAllocateGroups(ingesterAssignedGroups);
        }
    }   
}
