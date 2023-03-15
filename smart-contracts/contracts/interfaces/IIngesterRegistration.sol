// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.14;

interface IIngesterRegistration {

    struct Ingester {
        address ingesterAddress;
        bool verified;
        string[] assignedGroups;
    }
    struct IngesterToController {
        address controllerAddress;
        uint ingesterIndex;
    }

    event IngesterRegistered(address indexed controllerAddress, address indexed ingesterAddress);
    event IngesterUnRegistered(address indexed controllerAddress, address indexed ingesterAddress);

    function _hash(address _address, string memory _value, uint256 _nonce) external pure returns (bytes32);
    function recover(bytes32 messageHash, bytes memory sig) external pure returns (address);
    function getEthSignedMessageHash(bytes32 _messageHash) external pure returns (bytes32);
    function registerIngester(
        address ingesterAddress,
        string memory message,
        uint256 nonce,
        bytes memory sig
        ) external;
    // function unRegisteringIngester(address ingesterAddress, address originCaller) public returns(uint256[] memory);
}