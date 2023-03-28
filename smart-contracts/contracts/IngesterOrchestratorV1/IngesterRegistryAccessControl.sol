// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.14;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/access/AccessControlEnumerable.sol";

/**
 * @title IngesterRegistryAccessControlV2
 * @dev This contract manages access control and ownership for the Ingester Registry.
 * It extends the Ownable and AccessControlEnumerable contracts from the OpenZeppelin library.
 */
contract IngesterRegistryAccessControl is Ownable, AccessControlEnumerable {
    bytes32 public constant INGESTER_ROLE = keccak256("INGESTER_ROLE"); 

    /**
     * @notice Constructor for IngesterRegistryAccessControl contract.
     * @dev Sets the DEFAULT_ADMIN_ROLE to the contract deployer.
     */
    constructor() {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    /**
     * @dev Modifier to restrict function access only to the contract admins.
     * @notice Throws an error if the caller does not have the DEFAULT_ADMIN_ROLE.
     */
    modifier onlyAdmin() {
        require(hasRole(DEFAULT_ADMIN_ROLE, msg.sender), "Only admin can perform this action.");
        _;
    }

    /**
    * @dev Modifier to restrict function access only to the registered ingesters.
    * @notice Throws an error if the caller does not have the INGESTER_ROLE.
    */
    modifier onlyRegistered() {
        require(hasRole(INGESTER_ROLE, msg.sender), "Caller is not a registered ingester");
        _;
    }
    
    /**
    * @notice Transfers the ownership of the contract to a new address.
    * @dev Can only be called by an address with the DEFAULT_ADMIN_ROLE.
    * @param newOwner The address to transfer the ownership to.
    */
    function transferOwnership(address newOwner) public onlyAdmin override {
        super.transferOwnership(newOwner);
    }
}