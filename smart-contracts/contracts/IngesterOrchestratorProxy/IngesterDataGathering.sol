// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.14;

import "../interfaces/IngesterOrchestratorProxy/IIngesterDataGathering.sol";
import "@openzeppelin/contracts/access/AccessControlEnumerable.sol";
import "./IngesterProxy.sol";

/**
 * @title IngesterDataGathering
 * @dev This contract manages the storage of IPFS hashes stored by registered ingesters.
 * It extends the IngesterRegistryAccessControl which manages access control and ownership for the Ingester Registry and IngesterDataGatheringV2 interface
 */
contract IngesterDataGathering is
    AccessControlEnumerable,
    IIngesterDataGathering
{
    address public ingesterProxyAddress;
    IngesterProxy private _ingesterProxy;
    mapping(address => IIngesterDataGathering.IpfsHash) private _ipfsHashes;

    constructor() {
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    modifier onlyIngesterProxy() {
        require(msg.sender == ingesterProxyAddress, "Caller is not the IngesterProxy");
        _;
    }

    modifier onlyAdmin() {
        require(hasRole(DEFAULT_ADMIN_ROLE, msg.sender), "Only admin can perform this action.");
        _;
    }

    /**
    * @notice Updates the address of the IngesterProxy contract.
    * @param newIngesterProxy The address of the new IngesterProxy contract.
    */
    function updateIngesterProxy(address newIngesterProxy) external onlyAdmin {
        require(newIngesterProxy != address(0), "New ingester proxy address cannot be a zero address.");
        ingesterProxyAddress = newIngesterProxy;
        _ingesterProxy = IngesterProxy(newIngesterProxy);
        emit IIngesterDataGathering.IngesterProxyAddressUpdated(newIngesterProxy);
    }

    /**
     * @notice Adds IPFS hashes for a registered ingester.
     * @dev Can only be called by a registered ingester.
     * @param ingesterAddress The address of the registered ingester.
     * @param usersHash The IPFS hash of the users data.
     * @param chatsHash The IPFS hash of the chats data.
     * @param messagesHash The IPFS hash of the messages data.
     */
    function addIpfsHash(
        address ingesterAddress,
        string calldata usersHash,
        string calldata chatsHash,
        string calldata messagesHash
    ) external onlyIngesterProxy {

        IIngesterDataGathering.IpfsHash
            memory ipfsHashUsers = IIngesterDataGathering.IpfsHash(
                usersHash,
                chatsHash,
                messagesHash
            );
        _ipfsHashes[ingesterAddress] = ipfsHashUsers;
        emit IIngesterDataGathering.IpfsHashAdded(
            ingesterAddress,
            usersHash,
            chatsHash,
            messagesHash
        );
    }

    /**
     * @notice Gets the IPFS hashes for a registered ingester.
     * @dev Can be called by anyone.
     * @param ingesterAddress The address of the registered ingester.
     * @return ipfsHashes The IPFS struct of the ingester's data hashes.
     */
    function getIpfsHashes(
        address ingesterAddress
    ) public view returns (IpfsHash memory ipfsHashes) {
        return _ipfsHashes[ingesterAddress];
    }
}
