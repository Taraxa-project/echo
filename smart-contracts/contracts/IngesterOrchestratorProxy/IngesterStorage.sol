// pragma solidity 0.8.14;

// import "../interfaces/IngesterOrchestratorProxy/IIngesterOrchestratorStorage.sol";


// contract IngesterStorage is IIngesterOrchestratorStorage {

//     bytes32 public constant INGESTER_ROLE = keccak256("INGESTER_ROLE"); 

//     // State variables from orchestrator
//     uint256 public maxNumberIngesterPerGroup;
//     mapping(string => IIngesterOrchestratorStorage.GroupToIngester) public _groups;
//     string[] public _groupUsernames;
//     uint256 public _groupCount;


//     // State variables for storage
//     mapping(address => IIngesterOrchestratorStorage.Ingester) public _ingesters;
//     mapping(address => IIngesterOrchestratorStorage.IngesterToController) public _ingesterToController;
//     address[] public _ingesterAddresses;
//     uint public _ingesterCount;

//     // State variables for IPFS
//     mapping(address => IIngesterOrchestratorStorage.IpfsHash) public ipfsHashes;

//     // Getter and setter functions for state variables
//     /**
//     * @notice Retrieves information about a specific group.
//     * @param groupUsername The unique identifier (username) of the group to be queried.
//     * @return GroupToIngester A struct containing information about the group.
//     */
//     function getGroup(string calldata groupUsername) public view returns (GroupToIngester memory) {
//         IIngesterOrchestratorStorage.GroupToIngester memory group = IIngesterOrchestratorStorage.GroupToIngester(
//             _groups[groupUsername].isAdded,
//             _groups[groupUsername].ingesterAddresses, 
//             _groups[groupUsername].groupUsernameIndex
//         );
//         return group;
//     }

//     function incrementGroupCount() external {
//         ++_groupCount;
//     }


//     /**
//     * @notice Sets the maximum number of ingesters allowed per group.
//     * @dev Can only be called by an admin.
//     * @param maxNumberIngesterPerGroup The new maximum number of ingesters allowed per group.
//     */
//     function setMaxNumberIngesterPerGroup(uint256 maxNumberIngesterPerGroup) external onlyAdmin {
//         _maxNumberIngesterPerGroup = maxNumberIngesterPerGroup;
//         emit IIngesterOrchestratorStorage.SetNewMaxIngesterPerGroup(maxNumberIngesterPerGroup);
//     }

//     /**
//      * @notice Retrieves the ingester details based on the given address.
//      * @param ingesterAddress The address of the ingester.
//      * @return Ingester The Ingester struct containing ingester details.
//      */
//     function getIngester(address ingesterAddress) public view returns (IIngesterOrchestratorStorage.Ingester memory) {
//         require(_ingesterToController[ingesterAddress].controllerAddress != address(0), "Ingester does not exist.");
//         address controller = _ingesterToController[ingesterAddress].controllerAddress;
//         return _ingesters[controller][_ingesterToController[ingesterAddress].ingesterIndex];
//     }

//     function deleteIngesterAddress(uint256 ingesterAddressIndex) external {
//         delete _ingesterAddresses[_ingesterToController[ingesterAddress].ingesterAddressesIndex];
//     }

//     function deleteIngester(address originCaller, uint256 ingesterIndex) external {
//         delete _ingesters[originCaller][ingesterIndex]; 
//     }

//     // Getters
// function getMaxNumberIngesterPerGroup() public view returns (uint256) {
//     return maxNumberIngesterPerGroup;
// }

// function getGroup(string memory groupUsername) public view returns (GroupToIngester memory) {
//     return _groups[groupUsername];
// }

// function getGroupUsername(uint256 index) public view returns (string memory) {
//     return _groupUsernames[index];
// }

// function getGroupCount() public view returns (uint256) {
//     return _groupCount;
// }

// function getIngester(address ingesterAddress) public view returns (Ingester memory) {
//     return _ingesters[ingesterAddress];
// }

// function getIngesterToController(address ingesterAddress) public view returns (IngesterToController memory) {
//     return _ingesterToController[ingesterAddress];
// }

// function getIngesterAddress(uint256 index) public view returns (address) {
//     return _ingesterAddresses[index];
// }

// function getIngesterCount() public view returns (uint) {
//     return _ingesterCount;
// }

// function getIpfsHash(address ingesterAddress) public view returns (IpfsHash memory) {
//     return ipfsHashes[ingesterAddress];
// }

// // Setters
// function setMaxNumberIngesterPerGroup(uint256 value) external onlyAdmin {
//     maxNumberIngesterPerGroup = value;
// }

// function setGroup(string memory groupUsername, GroupToIngester memory group) external onlyAdmin {
//     _groups[groupUsername] = group;
// }

// function addGroupUsername(string memory groupUsername) external onlyAdmin {
//     _groupUsernames.push(groupUsername);
// }

// function incrementGroupCount() external onlyAdmin {
//     _groupCount++;
// }

// function decrementGroupCount() external onlyAdmin {
//     _groupCount--;
// }

// function setIngester(address ingesterAddress, Ingester memory ingester) external onlyAdmin {
//     _ingesters[ingesterAddress] = ingester;
// }

// function setIngesterToController(address ingesterAddress, IngesterToController memory ingesterToController) external onlyAdmin {
//     _ingesterToController[ingesterAddress] = ingesterToController;
// }

// function addIngesterAddress(address ingesterAddress) external onlyAdmin {
//     _ingesterAddresses.push(ingesterAddress);
// }

// function incrementIngesterCount() external onlyAdmin {
//     _ingesterCount++;
// }

// function decrementIngesterCount() external onlyAdmin {
//     _ingesterCount--;
// }

// function setIpfsHash(address ingesterAddress, IpfsHash memory ipfsHash) external onlyAdmin {
//     ipfsHashes[ingesterAddress] = ipfsHash;
// }




// }
