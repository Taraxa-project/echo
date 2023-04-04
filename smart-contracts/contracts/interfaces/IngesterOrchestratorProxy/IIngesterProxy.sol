// pragma solidity 0.8.14;

// interface IIngesterProxy {
//     function registerIngester(
//         address _ingesterAddress, 
//         string calldata message,
//         uint256 nonce,
//         bytes calldata sig
//     ) external;

//     function unRegisterIngester(address _ingesterAddress) external;

//     function addIngesterToCluster(address _ingesterAddress) external returns (uint256);

//     function removeIngesterFromCluster(address _ingesterAddress, uint256 _clusterId) external returns (uint256);

//     function isRegisteredIngester(address _ingesterAddress) external view returns (bool);

//     function isRegisteredController(address _controllerAddress) external view returns (bool);

//     function getIngesterDetails(address _ingesterAddress) external view returns (IngesterRegistry.Ingester memory);

//     function addAssignedGroupToIngester(address _ingesterAddress, string memory _groupUsername) external;

//     function moveIngesterAssignedGroup(address _ingesterAddress, uint256 _assignedGroupsIngesterIndex) external;

//     function setMaxNumberIngesterPerGroup(uint256 _maxNumberIngesterPerGroup) external;

//     function addGroup(string calldata _groupUsername) external;

//     function removeGroup(string calldata _groupUsername) external;

//     function removeIngesterFromGroups(string[] memory _groups, address _ingesterAddress) external;

//     function distributeGroupPostUnregistration(string[] memory _groups) external;

//     function addIpfsHash(
//         address _ingesterAddress,
//         string calldata _usersHash,
//         string calldata _chatsHash,
//         string calldata _messagesHash
//     ) external;

//     function getIpfsHashes(address _ingesterAddress) external view returns(IIngesterDataGatheringProxy.IpfsHash memory ipfsHashes);
// }



