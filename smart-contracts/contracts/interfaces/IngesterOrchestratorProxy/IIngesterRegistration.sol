// SPDX-License-Identifier: MIT
pragma solidity 0.8.14;

interface IIngesterRegistration {
    
    struct Ingester {
        address ingesterAddress;
        bool verified;
        uint256 clusterId;
    }

    struct IngesterWithGroups {
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
    function isRegisteredIngester(address ingesterAddress) external view returns (bool);
    function isRegisteredController(address _controllerAddress) external view returns (bool);
    function getIngester(address _ingesterAddress) external view returns (Ingester memory);
    function getIngesterWithGroups(address ingesterAddress) external view returns (IngesterWithGroups memory);
    function getIngesterToController(address _ingesterAddresses) external view returns (IngesterToController memory);
    function getIngesterAddressFromIndex(uint256 index) external view returns (address);
    function getControllerIngesters(address controllerAddress) external view returns (IIngesterRegistration.Ingester[] memory);
    function updateIngesterProxy(address newIngesterProxy) external;

    event IngesterRegistered(address indexed controllerAddress, address indexed ingesterAddress);
    event IngesterUnRegistered(address indexed controllerAddress, address indexed ingesterAddress);
    event IngesterAssignedGroupsUpdated(address indexed ingesterAddress, string[] assignedGroups);
    event AssignGroupToIngester(address indexed ingesterAddress, string groupUsername);
    event IngesterProxyAddressUpdated(address indexed newIngesterProxy);

}

