// SPDX-License-Identifier: MIT
pragma solidity 0.8.14;

interface IIngesterRegistration {
    
    struct Ingester {
        address ingesterAddress;
        bool verified;
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
        address _controllerAddress,
        string calldata message,
        uint256 nonce,
        bytes calldata sig
        ) external;
    function unRegisterIngester(
        address ingesterAddress,
        address _controllerAddress) external;
    function getIngesterDetails(address _ingesterAddress) external view returns (Ingester memory);
    function setIngesterDetails(Ingester calldata _ingester, address _ingesterAddress) external returns (Ingester memory);
    function addAssignedGroupToIngester(address _ingesterAddress, string calldata _groupUsername) external;
    function getIngesterToController(address _ingesterAddresses) external view returns (IngesterToController memory);
    function getIngesterAddress(uint256 index) external view returns (address);
    function moveIngesterAssignedGroup(address _ingesterAddress, uint256 assignedGroupsIngesterIndex) external;

    event IngesterRegistered(address indexed controllerAddress, address indexed ingesterAddress);
    event IngesterUnRegistered(address indexed controllerAddress, address indexed ingesterAddress);
    
    event IngesterAssignedGroupsUpdated(address indexed ingesterAddress, string[] assignedGroups);
    event AssignGroupToIngester(address indexed ingesterAddress, string groupUsername);

}

