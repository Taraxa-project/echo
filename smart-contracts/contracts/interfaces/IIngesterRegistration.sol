// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IIngesterRegistration {
    
    struct Ingester {
        address ingesterAddress;
        bool verified;
        bool isAllocated;
        uint256 clusterId;
    }

    struct IngesterWithGroups {
        address ingesterAddress;
        bool verified;
        bool isAllocated;
        uint256 clusterId;
        string[] assignedGroups;
    }

    struct IngesterToController {
        address controllerAddress;
        uint ingesterIndex;
        uint ingesterAddressesIndex;
    }

    function registerIngester(
        address ingesterAddress,
        string calldata message,
        uint256 nonce,
        bytes calldata sig
        ) external;
    function unRegisterIngester(address ingesterAddress) external;

    event IngesterRegistered(address indexed controllerAddress, address indexed ingesterAddress);
    event IngesterUnRegistered(address indexed controllerAddress, address indexed ingesterAddress);
    event UnAllocatedIngesterAdded(address indexed ingesterAddress);
    event ClusterHasNoIngesters(uint256 clusterId);
    event IngesterAddedToCluster(uint256 indexed clusterId, address indexed ingesterAddress);
    event IngesterRemovedFromCluster(uint256 indexed clusterId, address indexed ingesterAddress);



}

